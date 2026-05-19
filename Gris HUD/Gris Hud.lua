-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_camera_angles, client_create_interface, client_delay_call, client_get_cvar, client_reload_active_scripts, client_screen_size, entity_get_local_player, entity_get_origin, entity_get_player_name, entity_get_prop, entity_is_alive, globals_frametime, globals_tickinterval, math_max, math_min, math_sqrt, pairs, renderer_gradient, renderer_load_rgba, renderer_measure_text, renderer_text, renderer_texture, string_format, table_remove, tonumber, ui_new_checkbox, tostring, print, loadstring, error, ui_get, ui_set_callback = client.camera_angles, client.create_interface, client.delay_call, client.get_cvar, client.reload_active_scripts, client.screen_size, entity.get_local_player, entity.get_origin, entity.get_player_name, entity.get_prop, entity.is_alive, globals.frametime, globals.tickinterval, math.max, math.min, math.sqrt, pairs, renderer.gradient, renderer.load_rgba, renderer.measure_text, renderer.text, renderer.texture, string.format, table.remove, tonumber, ui.new_checkbox, tostring, print, loadstring, error, ui.get, ui.set_callback

local ffi = require 'ffi'
local http = require 'gamesense/http'
local surface = require 'gamesense/surface'

local cl_showpos = cvar.cl_showpos
local cl_hud_playercount_pos = cvar.cl_hud_playercount_pos
local cl_drawhud_force_radar = cvar.cl_drawhud_force_radar
local surface_draw_text, surface_measure_text = surface.draw_text, surface.measure_text

local engine_client = ffi.cast(ffi.typeof('void***'), client_create_interface('engine.dll', 'VEngineClient014'))
local Con_IsVisible = ffi.cast(ffi.typeof('bool(__thiscall*)(void*)'), engine_client[0][11])

local icons_url = 'https://gist.githubusercontent.com/tickcount/6a03480a124036684e15fe9a3d19593f/raw/34c03223c0f5d0ad6bea7978be2dae6fe69e4074/gris_images.lua'
local load_textures = function(image_rgba, width)
    if image_rgba == nil or image_rgba.HD == nil then
        return
    end

    local textures = { }
    local r_image = image_rgba.HD

    if width >= 1920 and image_rgba.FHD ~= nil then r_image = image_rgba.FHD end
    if width >= 2560 and image_rgba.WQHD ~= nil then r_image = image_rgba.WQHD end
    if width >= 3840 and image_rgba.UHD ~= nil then r_image = image_rgba.UHD end

    for k, v in pairs(r_image) do
        textures[k] = k ~= 'addr' and { v[1], v[2], renderer_load_rgba(v[3], v[1], v[2]) } or v
    end

    return textures
end

local CConPanel = function(font_data)
    if font_data == nil or font_data.name == nil then
        font_data = {
            name = 'Verdana',
            tall = 12,
            weight = 400,
            flags = { 0x080 }
        }
    end

    local this = { }
    local m_NotifyText = { }
    local m_LogLineBuffer = { }
    local bShouldEmptyLineBuffer = false

    local developer = cvar.developer
    local con_notifytime = cvar.con_notifytime

    local font, fontTall = surface.create_font(
        font_data.name,
        font_data.tall,
        font_data.weight,
        font_data.flags
    ), font_data.tall+3

    function this:clear_notify()
        m_NotifyText = { }
    end

    function this:clamp(val, min, max)
        if val <= min then return min end
        if val >= max then return max end

        return val
    end

    function this:should_draw()
        local bVisible = false
        local con_visible = Con_IsVisible and Con_IsVisible(engine_client) or false

        if not con_visible then
            for i=#m_NotifyText, 1, -1 do
                m_NotifyText[i].liferemaining =
                    m_NotifyText[i].liferemaining - globals_frametime()

                if m_NotifyText[i].liferemaining <= 0.0 then
                    table_remove(m_NotifyText, i)
                else
                    bVisible = true
                end
            end
        else
            bVisible = true
        end

        return bVisible
    end

    function this:draw_notify(x, y)
        local x = x or 8
        local y = y or 5

        local count = #m_NotifyText
        local alpha = 255

        for i=count, 1, -1 do
            local notify = m_NotifyText[i]

            local timeleft = notify.liferemaining
            local clr = notify.data.color
            local text_offset = 0

            if timeleft < .5 then
                local f = this:clamp(timeleft, 0, .5) / .5

                alpha = f * 255

                if i == count and f < .2 then
                    y = y - fontTall * (1 - f / 0.2)
                end
            else
                alpha = 255
            end

            for i=1, #notify.data do
                local current = notify.data[i]
                local width = surface_measure_text(font, current.text)

                surface_draw_text(x + text_offset, y, current.color[1], current.color[2], current.color[3], alpha, font, current.text)
                text_offset = text_offset + width
            end

            y = y + fontTall
        end
    end

    function this:add_to_notify(args)
        if  args == nil or args.text == nil or args.color == nil or
            args.text == '' or #args.color < 3
        then
            return
        end

        for i = 5, 2, -1 do
            m_NotifyText[i] = m_NotifyText[i-1]
        end

        local m_Pattern = '\1'

        if args.text:find(m_Pattern) then
            args.text = args.text:gsub(m_Pattern, '') .. ' '
            bShouldEmptyLineBuffer = false
        else
            bShouldEmptyLineBuffer = true
        end

        m_LogLineBuffer[#m_LogLineBuffer+1] = args

        if bShouldEmptyLineBuffer then
            m_NotifyText[1] = {
                data = m_LogLineBuffer,
                liferemaining = con_notifytime:get_float()
            }

            m_LogLineBuffer = { }
        end
    end

    return this
end

local render_box = function(x, y, text, color, alpha)
    if text == nil then
        return
    end

    local text = text
    local h, w = 17, renderer_measure_text(nil, text) + 8

    local x = x - w/2

    renderer_gradient(x-1, y, (w+1) / 2, h, 0, 0, 0, 25, 17, 17, 17, alpha, true)
    renderer_gradient(x-1 + w/2, y, (w+1) / 2, h, 17, 17, 17, alpha, 0, 0, 0, 25, true)

    if color ~= nil then
        local r, g, b = color[1], color[2], color[3]

        renderer_gradient(x-1, y-1, (w+1) / 2, 2, 0, 0, 0, 25, r, g, b, math_max(alpha*2.5, 255), true)
        renderer_gradient(x-1 + w/2, y-1, (w+1) / 2, 2, r, g, b, math_max(alpha*2.5, 255), 0, 0, 0, 25, true)
    end

    renderer_text(x+3, y + 2, 255, 255, 255, 255, "", 0, text)

    return h+2
end

local player_handle = function(me, sz, active)
    cl_showpos:set_raw_int(0)

    if me == nil or tonumber(active) == 0 then
        return
    end

    local alpha, offset = 95, 0
    local x, y = sz[1] / 2, sz[2] / 13

    if cl_hud_playercount_pos:get_int() == 1 then
        y = 16
    end

    local stamina = entity_get_prop(me, 'm_flStamina')
    local m_vel = { entity_get_prop(me, 'm_vecVelocity') }

    local stamina_clr = { 0, 255, 45 }
    if stamina > 0 then stamina_clr = { 255, 255, 25 } end
    if stamina > 20 then stamina_clr = { 255, 0, 0 } end

    offset = offset + render_box(x, y+offset, ('stamina: %.1f'):format(80-stamina), stamina_clr, alpha)
    offset = offset + render_box(x, y+offset, ('name: %s'):format(entity_get_player_name(me)), nil, alpha)
    offset = offset + render_box(x, y+offset, ('pos: [%.1f / %.1f / %.1f]'):format(entity_get_origin(me)), nil, alpha)
    offset = offset + render_box(x, y+offset, ('ang: [%.1f / %.1f / %.1f]'):format(client_camera_angles()), nil, alpha)
    offset = offset + render_box(x, y+offset, ('velocity: %.2f'):format(math_sqrt(m_vel[1]^2 + m_vel[2]^2)), nil, alpha)
end

-- UI Initialization
local master_switch = ui_new_checkbox('VISUALS', 'Other ESP', 'Gris HUD')

http.request('GET', icons_url, function(success, response)
    if not success or response.status ~= 200 then
        return print(string_format(
            'error while sending request [code: %d | body: %s]',
            tostring(response.status), tostring(response.body)
        ))
    end

    local screen_width = client_screen_size()
    local images = loadstring(response.body)()
    local textures = load_textures(images, screen_width)

    local con_panel = CConPanel()

    if textures == nil then
        error 'error while loading textures'
    end

    local c_pos = { 11, 0 }
    local c_health, c_alpha = 0, 0

    local get_health = function(health)
        local delta = 100-math_min(health or 0, 100)
        local add_dist = (delta - c_health) / 25

        c_health = c_health + (c_health < delta and add_dist or -add_dist)
        c_health = c_health > delta and delta or c_health

        return 100-c_health
    end

    local g_paint_handler = function()
        local screen_size = { client_screen_size() }
        local frames = 4 * globals_frametime()
        local panel = { 12, 9 }

        if screen_size[1] > 0 and screen_size[1] ~= screen_width then
            client_delay_call(globals_tickinterval()*1, function()
                client_reload_active_scripts()
            end)

            return error('[Gris UI] Detected screen size update, reloading handle', 2)
        end

        local me = entity_get_local_player()
        local is_valid = me ~= nil and entity_is_alive(me)
        local health = get_health(is_valid and entity_get_prop(me, 'm_iHealth') or 0)

        renderer_texture(textures.background[3], c_pos[1], c_pos[2], textures.background[1], textures.background[2], 255, 255, 255, c_alpha*255, 'r')
        renderer_texture(textures.bar[3], c_pos[1] + textures.addr[1], c_pos[2] + textures.addr[2], textures.bar[1] / 100 * health, textures.bar[2], 255, 255, 255, c_alpha*255, 'r')

        if c_alpha > 0 then
            panel = {
                c_pos[1] + textures.addr[3],
                c_pos[2] + textures.background[2]
            }
        end

        con_panel:should_draw()
        con_panel:draw_notify(panel[1], panel[2])

        player_handle(me, screen_size, client_get_cvar('cl_showpos'))

        c_alpha = con_panel:clamp(c_alpha + (health > 1 and frames or -frames), 0, 1)
    end

    local g_output_handler = function(args)
        con_panel:add_to_notify({
            text = args.text,
            color = { args.r, args.g, args.b }
        })
    end

    local g_shutdown_handler = function()
        cl_drawhud_force_radar:set_int(0)
        cl_showpos:set_int(client_get_cvar('cl_showpos'))
    end

    local g_ui_callback = function(c)
        local ac = ui_get(c)

        local addr = not ac and 'un' or ''
        local set_callback = client[addr .. 'set_event_callback']

        cl_drawhud_force_radar:set_int(ac and -1 or 0)
        cl_showpos:set_int(client_get_cvar('cl_showpos'))

        set_callback('paint', g_paint_handler)
        set_callback('output', g_output_handler)
        set_callback('shutdown', g_shutdown_handler)
    end

    ui_set_callback(master_switch, g_ui_callback)
    g_ui_callback(master_switch)
end)
