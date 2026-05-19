local ffi = require 'ffi'
local bit = require 'bit'

local vector = require 'vector'
local base64 = require 'gamesense/base64'
local anti_aim = require 'antiaim_funcs'

local new_char_arr = ffi.typeof 'char[?]'

local client_dll = ffi.cast('uintptr_t**', client.create_interface('client.dll', 'VClient018'))[0]
local client_mode = ffi.cast('void***', client_dll[10] + ffi.cast('unsigned long', 0x5))[0][0]
local should_draw_viewmodel = ffi.cast('bool(__thiscall*)(void*)', ffi.cast('int**', client_mode)[0][27])

local get_attachment = vtable_thunk(84, 'bool(__thiscall*)(void*, int, void*)')
local get_muzzle_attachment_index_1stperson = vtable_thunk(468, 'int(__thiscall*)(void*, void*)')
local get_muzzle_attachment_index_3rdperson = vtable_thunk(469, 'int(__thiscall*)(void*)')

local get_clipboard_text_count = vtable_bind('vgui2.dll', 'VGUI_System010', 7, 'int(__thiscall*)(void*)')
local set_clipboard_text = vtable_bind('vgui2.dll', 'VGUI_System010', 9, 'void(__thiscall*)(void*, const char*, int)')
local get_clipboard_text = vtable_bind('vgui2.dll', 'VGUI_System010', 11, 'int(__thiscall*)(void*, int, const char*, int)')

local get_client_entity = vtable_bind('client.dll', 'VClientEntityList003', 3, 'void*(__thiscall*)(void*, int)')

local tween = (function()local a={}local b,c,d,e,f,g,h=math.pow,math_sin,math_cos,math.pi,math_sqrt,math_abs,math.asin;local function i(j,k,l,m)return l*j/m+k end;local function n(j,k,l,m)return l*b(j/m,2)+k end;local function o(j,k,l,m)j=j/m;return-l*j*(j-2)+k end;local function p(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,2)+k end;return-l/2*((j-1)*(j-3)-1)+k end;local function q(j,k,l,m)if j<m/2 then return o(j*2,k,l/2,m)end;return n(j*2-m,k+l/2,l/2,m)end;local function r(j,k,l,m)return l*b(j/m,3)+k end;local function s(j,k,l,m)return l*(b(j/m-1,3)+1)+k end;local function t(j,k,l,m)j=j/m*2;if j<1 then return l/2*j*j*j+k end;j=j-2;return l/2*(j*j*j+2)+k end;local function u(j,k,l,m)if j<m/2 then return s(j*2,k,l/2,m)end;return r(j*2-m,k+l/2,l/2,m)end;local function v(j,k,l,m)return l*b(j/m,4)+k end;local function w(j,k,l,m)return-l*(b(j/m-1,4)-1)+k end;local function x(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,4)+k end;return-l/2*(b(j-2,4)-2)+k end;local function y(j,k,l,m)if j<m/2 then return w(j*2,k,l/2,m)end;return v(j*2-m,k+l/2,l/2,m)end;local function z(j,k,l,m)return l*b(j/m,5)+k end;local function A(j,k,l,m)return l*(b(j/m-1,5)+1)+k end;local function B(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,5)+k end;return l/2*(b(j-2,5)+2)+k end;local function C(j,k,l,m)if j<m/2 then return A(j*2,k,l/2,m)end;return z(j*2-m,k+l/2,l/2,m)end;local function D(j,k,l,m)return-l*d(j/m*e/2)+l+k end;local function E(j,k,l,m)return l*c(j/m*e/2)+k end;local function F(j,k,l,m)return-l/2*(d(e*j/m)-1)+k end;local function G(j,k,l,m)if j<m/2 then return E(j*2,k,l/2,m)end;return D(j*2-m,k+l/2,l/2,m)end;local function H(j,k,l,m)if j==0 then return k end;return l*b(2,10*(j/m-1))+k-l*.001 end;local function I(j,k,l,m)if j==m then return k+l end;return l*1.001*(-b(2,-10*j/m)+1)+k end;local function J(j,k,l,m)if j==0 then return k end;if j==m then return k+l end;j=j/m*2;if j<1 then return l/2*b(2,10*(j-1))+k-l*.0005 end;return l/2*1.0005*(-b(2,-10*(j-1))+2)+k end;local function K(j,k,l,m)if j<m/2 then return I(j*2,k,l/2,m)end;return H(j*2-m,k+l/2,l/2,m)end;local function L(j,k,l,m)return-l*(f(1-b(j/m,2))-1)+k end;local function M(j,k,l,m)return l*f(1-b(j/m-1,2))+k end;local function N(j,k,l,m)j=j/m*2;if j<1 then return-l/2*(f(1-j*j)-1)+k end;j=j-2;return l/2*(f(1-j*j)+1)+k end;local function O(j,k,l,m)if j<m/2 then return M(j*2,k,l/2,m)end;return L(j*2-m,k+l/2,l/2,m)end;local function P(Q,R,l,m)Q,R=Q or m*.3,R or 0;if R<g(l)then return Q,l,Q/4 end;return Q,R,Q/(2*e)*h(l/R)end;local function S(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m;if j==1 then return k+l end;Q,R,T=P(Q,R,l,m)j=j-1;return-(R*b(2,10*j)*c((j*m-T)*2*e/Q))+k end;local function U(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m;if j==1 then return k+l end;Q,R,T=P(Q,R,l,m)return R*b(2,-10*j)*c((j*m-T)*2*e/Q)+l+k end;local function V(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m*2;if j==2 then return k+l end;Q,R,T=P(Q,R,l,m)j=j-1;if j<0 then return-.5*R*b(2,10*j)*c((j*m-T)*2*e/Q)+k end;return R*b(2,-10*j)*c((j*m-T)*2*e/Q)*.5+l+k end;local function W(j,k,l,m,R,Q)if j<m/2 then return U(j*2,k,l/2,m,R,Q)end;return S(j*2-m,k+l/2,l/2,m,R,Q)end;local function X(j,k,l,m,T)T=T or 1.70158;j=j/m;return l*j*j*((T+1)*j-T)+k end;local function Y(j,k,l,m,T)T=T or 1.70158;j=j/m-1;return l*(j*j*((T+1)*j+T)+1)+k end;local function Z(j,k,l,m,T)T=(T or 1.70158)*1.525;j=j/m*2;if j<1 then return l/2*j*j*((T+1)*j-T)+k end;j=j-2;return l/2*(j*j*((T+1)*j+T)+2)+k end;local function _(j,k,l,m,T)if j<m/2 then return Y(j*2,k,l/2,m,T)end;return X(j*2-m,k+l/2,l/2,m,T)end;local function a0(j,k,l,m)j=j/m;if j<1/2.75 then return l*7.5625*j*j+k end;if j<2/2.75 then j=j-1.5/2.75;return l*(7.5625*j*j+.75)+k elseif j<2.5/2.75 then j=j-2.25/2.75;return l*(7.5625*j*j+.9375)+k end;j=j-2.625/2.75;return l*(7.5625*j*j+.984375)+k end;local function a1(j,k,l,m)return l-a0(m-j,0,l,m)+k end;local function a2(j,k,l,m)if j<m/2 then return a1(j*2,0,l,m)*.5+k end;return a0(j*2-m,0,l,m)*.5+l*.5+k end;local function a3(j,k,l,m)if j<m/2 then return a0(j*2,k,l/2,m)end;return a1(j*2-m,k+l/2,l/2,m)end;a.easing={linear=i,inQuad=n,outQuad=o,inOutQuad=p,outInQuad=q,inCubic=r,outCubic=s,inOutCubic=t,outInCubic=u,inQuart=v,outQuart=w,inOutQuart=x,outInQuart=y,inQuint=z,outQuint=A,inOutQuint=B,outInQuint=C,inSine=D,outSine=E,inOutSine=F,outInSine=G,inExpo=H,outExpo=I,inOutExpo=J,outInExpo=K,inCirc=L,outCirc=M,inOutCirc=N,outInCirc=O,inElastic=S,outElastic=U,inOutElastic=V,outInElastic=W,inBack=X,outBack=Y,inOutBack=Z,outInBack=_,inBounce=a1,outBounce=a0,inOutBounce=a2,outInBounce=a3}local function a4(a5,a6,a7)a7=a7 or a6;local a8=getmetatable(a6)if a8 and getmetatable(a5)==nil then setmetatable(a5,a8)end;for a9,aa in pairs(a6)do if type(aa)=='table'then a5[a9]=a4({},aa,a7[a9])else a5[a9]=a7[a9]end end;return a5 end;local function ab(ac,ad,ae)ae=ae or{}local af,ag;for a9,ah in pairs(ad)do af,ag=type(ah),a4({},ae)table.insert(ag,tostring(a9))if af=='number'then assert(type(ac[a9])=='number','Parameter \''..table.concat(ag,'/')..'\' is missing from subject or isn\'t a number')elseif af=='table'then ab(ac[a9],ah,ag)else assert(af=='number','Parameter \''..table.concat(ag,'/')..'\' must be a number or table of numbers')end end end;local function ai(aj,ac,ad,ak)assert(type(aj)=='number'and aj>0,'duration must be a positive number. Was '..tostring(aj))local al=type(ac)assert(al=='table'or al=='userdata','subject must be a table or userdata. Was '..tostring(ac))assert(type(ad)=='table','target must be a table. Was '..tostring(ad))assert(type(ak)=='function','easing must be a function. Was '..tostring(ak))ab(ac,ad)end;local function am(ak)ak=ak or'linear'if type(ak)=='string'then local an=ak;ak=a.easing[an]if type(ak)~='function'then error('The easing function name \''..an..'\' is invalid')end end;return ak end;local function ao(ac,ad,ap,aq,aj,ak)local j,k,l,m;for a9,aa in pairs(ad)do if type(aa)=='table'then ao(ac[a9],aa,ap[a9],aq,aj,ak)else j,k,l,m=aq,ap[a9],aa-ap[a9],aj;ac[a9]=ak(j,k,l,m)end end end;local ar={}local as={__index=ar}function ar:set(aq)assert(type(aq)=='number','clock must be a positive number or 0')self.initial=self.initial or a4({},self.target,self.subject)self.clock=aq;if self.clock<=0 then self.clock=0;a4(self.subject,self.initial)elseif self.clock>=self.duration then self.clock=self.duration;a4(self.subject,self.target)else ao(self.subject,self.target,self.initial,self.clock,self.duration,self.easing)end;return self.clock>=self.duration end;function ar:reset()return self:set(0)end;function ar:update(at)assert(type(at)=='number','dt must be a number')return self:set(self.clock+at)end;function a.new(aj,ac,ad,ak)ak=am(ak)ai(aj,ac,ad,ak)return setmetatable({duration=aj,subject=ac,target=ad,easing=ak,clock=0},as)end;return a end)()

local get_color = function(b,c,d)local e={{255,0,0},{237,27,3},{235,63,6},{229,104,8},{228,126,10},{220,169,16},{213,201,19},{176,205,10},{124,195,13}}local f=function(g,c,h)local g=g>c and c or g;local i=c/g;if not h then h=c end;local d=h/i;d=d>=0 and math.floor(d+.5)or math.ceil(d-.5)return d end;d=f(b,c,#e)return e[d<=1 and 1 or d][1],e[d<=1 and 1 or d][2],e[d<=1 and 1 or d][3],d end
local get_scoreboard = panorama.loadstring('return $.GetContextPanel().FindChildTraverse(\'ScoreboardContainer\').FindChildTraverse(\'Scoreboard\') || $.GetContextPanel().FindChildTraverse(\'id-eom-scoreboard-container\').FindChildTraverse(\'Scoreboard\')', 'CSGOHud')

local create_blur_instance = function()
    local panorama_code = [[
        return {
            new: function() {
                let context_panel = $.GetContextPanel();
                let panel = $.CreatePanel('Panel', context_panel, 'Leaf');
                let co_r = function(res, or) { return (res/or)*100 }

                if(!panel)
                    return;

                let layout = `
                    <root>
                        <styles>
                            <include src='file://{resources}/styles/csgostyles.css' />
                            <include src='file://{resources}/styles/hud/hud.css' />
                        </styles>

                        <Panel class='full-width full-height' hittest='false' hittestchildren='false'>
                            <CSGOBlurTarget id='HudBlurG' style='width:100%;height:100%;-s2-mix-blend-mode:normal;'>
                                    <CSGOBackbufferImagePanel class='full-width full-height' />
                            </CSGOBlurTarget>
                        </Panel>
                    </root>
                `;

                if(!panel.BLoadLayoutFromString(layout, false, false))
                    return;

                panel.visible = false;
                panel.GetChild(0).style.opacity = 0;
                panel.GetChild(0).style.blur = `fastgaussian(1,1,1)`;
                panel.style.clip = `rect(0%, 0%, 0%, 0%)`;

                return {
                    set_state: function(gauss, alpha) {
                        if (panel == null)
                            return;

                        if (gauss != null)
                            panel.GetChild(0).style.blur = `fastgaussian(${gauss},${gauss},${gauss})`;

                        if (alpha != null)
                        {
                            panel.visible = alpha > .000;
                            panel.GetChild(0).style.opacity = alpha;
                        }
                    },

                    set_position: function(x, y, w, h) {
                        if (panel == null || (context_panel.contentwidth == 0 || context_panel.contentheight == 0))
                            return;

                        let _x = co_r(x, context_panel.contentwidth);
                        let _y = co_r(y, context_panel.contentheight);
                        w = co_r(x+w, context_panel.contentwidth);
                        h = co_r(y+h, context_panel.contentheight);

                        panel.style.clip = `rect(${_y}%, ${_x}%, ${h}%, ${w}%)`;
                    },

                    release: function() {
                        if (panel == null)
                            return;

                        panel.RemoveAndDeleteChildren();
                        panel.DeleteAsync(.0);
                        panel = null;
                    }
                }
            }
        }
    ]]

    local panels = {
        'CSGOHud',
        'CSGOMainMenu',
        'CSGOLoadingScreen'
    }

    local mt = { }
    local mt_data = {
        factor = 1,
        is_active = false,

        visibility = 0,

        pos = vector(0, 0),
        size = vector(0, 0),

        callbacks = { }
    }

    mt.create = function(self)
        for _, name in pairs(panels) do
            local blur = panorama.loadstring(panorama_code, name)()
            local status, new_panel = pcall(function()
                return blur.new()
            end)

            if not status then
                print(('[blur:%s] %s'):format(name:lower(), new_panel))
            else
                self.callbacks[#self.callbacks+1] = new_panel
            end
        end

        return #self.callbacks > 0
    end

    mt.renderer_rect = function(self, pos, size, factor, visibility)
        if  factor == nil or visibility == nil or
            pos == nil or size == nil or
            pos.x == nil or size.x == nil or
            factor <= 0 or visibility <= 0
        then
            self.is_active = false
            return
        end

        self.is_active = true
        self.factor, self.visibility = factor, visibility
        self.pos, self.size = pos, size
    end

    local eblur = setmetatable(mt_data, {
        __index = mt
    })

    if not eblur:create() then
        error('Couldn\'t create blur instance', 2)
        return
    end

    local on_shutdown = function()
        for id, instance in pairs(eblur.callbacks) do
            local success, response = pcall(function()
                instance.release()
            end)

            if not success then
                print(('Failed to shutdown blur instance [%s]'):format(response))
            end
        end
    end

    local on_render = function()
        for _, instance in pairs(eblur.callbacks) do
            if not eblur.is_active then
                instance.set_state(nil, 0)
            else
                instance.set_state(eblur.factor, eblur.visibility)
                instance.set_position(
                    eblur.pos.x, eblur.pos.y,
                    eblur.size.x, eblur.size.y
                )
            end
        end

        eblur.is_active = false
    end

    client.set_event_callback('shutdown', on_shutdown)
    client.set_event_callback('pre_render', on_render)

    return eblur
end

-- UI References
local thirdperson = { ui.reference('VISUALS', 'Effects', 'Force third person (alive)') }
local onshot_aa = { ui.reference('AA', 'Other', 'On shot anti-aim') }

-- Renderer Functions
local function interpolate_colors(color1, color2, factor)
    local temp_array, temp_array_count = { }, 1
    local color3 = { color1[1], color1[2], color1[3], color1[4] }

    for i=1, 4 do
        temp_array[temp_array_count] = tonumber(('%.0f'):format(
            color3[i] + factor * (color2[i] - color1[i])
        ))

        temp_array_count = temp_array_count + 1
    end

    return temp_array
end

local function interpolate_colors_range(color1, color2, steps)
    local factor = 1 / (steps - 1)
    local temp_array, temp_array_count = { }, 1

    for i=0, steps-1 do
        temp_array[temp_array_count] = interpolate_colors(color1, color2, factor*i)
        temp_array_count = temp_array_count + 1
    end

    return temp_array
end

local function renderer_line_gradient(pos1, pos2, color1, color2, step)
    if color1[4] < 5 and color2[4] < 5 then
        -- skipping expensive checks
        return
    end

    local difference, step =
        pos2-pos1, step or 16

    local width, height =
        difference.x, difference.y

    local length = math.min(step, math.sqrt(width*width + height*height))
    local step_x, step_y =
        width / length, height / length

    local colors = interpolate_colors_range(color1, color2, length)

    for i=1, length do
        renderer.line(
            pos1.x + step_x*(i-1), pos1.y + step_y*(i-1),
            pos1.x + step_x*i, pos1.y + step_y*i,
            colors[i][1], colors[i][2], colors[i][3], colors[i][4]
        )
    end
end

local function renderer_glow_line(pos1, pos2, color1, color2, color_interp, width, step, speed)
    local lerp_center = pos1:lerp(pos2, .5)

    renderer_line_gradient(pos1, lerp_center, { color1[1], color1[2], color1[3], 0 }, { color1[1], color1[2], color1[3], color1[4] }, color_interp)
    renderer_line_gradient(lerp_center, pos2, { color1[1], color1[2], color1[3], color1[4] }, { color2[1], color2[2], color2[3], 0 }, color_interp)

    local a = color1[4] / 2
    local lerp_step = 1 / (width*step)

    local realtime =
        math.sin(globals.realtime() * speed) / 2 + .5

    local perpendicular =
        (pos2-pos1):normalized():cross(vector(0, 0, 1))

    for i = 1, width do
        local v1, v2 =
            pos1 + perpendicular * i,
            pos2 + perpendicular * i

        local v1v2center = v1:lerp(v2, .5)

        v1, v2 =
            v1v2center:lerp(v1, 1 - lerp_step * i),
            v1v2center:lerp(v2, 1 - lerp_step * i)

        local v3, v4 =
            pos1 - perpendicular * i,
            pos2 - perpendicular * i

        local v3v4center = v3:lerp(v4, .5)

        v3, v4 =
            v3v4center:lerp(v3, 1 - lerp_step * i),
            v3v4center:lerp(v4, 1 - lerp_step * i)

        local multiplier = 1 - math.log10(i) / math.log10(width)
        local alpha = a * multiplier

        if speed and speed > 0 then
            alpha = alpha * realtime
        end

        renderer_line_gradient(v1, v1v2center, { color1[1], color1[2], color1[3], 0 }, { color1[1], color1[2], color1[3], alpha }, color_interp)
        renderer_line_gradient(v1v2center, v2, { color1[1], color1[2], color1[3], alpha }, { color2[1], color2[2], color2[3], 0 }, color_interp)
        renderer_line_gradient(v3, v3v4center, { color1[1], color1[2], color1[3], 0 }, { color1[1], color1[2], color1[3], alpha }, color_interp)
        renderer_line_gradient(v3v4center, v4, { color1[1], color1[2], color1[3], alpha }, { color2[1], color2[2], color2[3], 0 }, color_interp)
    end
end

local function renderer_rounded_rect(args)
    local pos, size, r, color, outline, shadow, galpha =
        args.position, args.size, args.roundness, args.color, args.outline, args.shadow,
        args.alpha and args.alpha/255 or 1

    pos.x, pos.y = math.floor(pos.x), math.floor(pos.y)
    size.x, size.y = math.floor(size.x), math.floor(size.y)

    r = math.min(r, size.y / 2)

    if shadow and shadow.steps and shadow.range and shadow.color then
        local color, outline_thickness = shadow.color, 1
        local steps = math.max(2, shadow.steps)

        local colors = interpolate_colors_range(
            { color[1], color[2], color[3], 0 },
            { color[1], color[2], color[3], shadow.range * (color[4]*galpha) },
            steps
        )

        for i=1, steps do
            renderer.circle_outline(pos.x + r, pos.y + r, colors[i][1], colors[i][2], colors[i][3], colors[i][4]*galpha, r+outline_thickness+(steps-i), 180, .25, 1)
            renderer.circle_outline(pos.x + size.x - r, pos.y + r, colors[i][1], colors[i][2], colors[i][3], colors[i][4]*galpha, r+outline_thickness+(steps-i), 270, .25, 1)
            renderer.circle_outline(pos.x + size.x - r, pos.y + size.y - r, colors[i][1], colors[i][2], colors[i][3], colors[i][4]*galpha, r+outline_thickness+(steps-i), 0, .25, 1)
            renderer.circle_outline(pos.x + r, pos.y + size.y - r, colors[i][1], colors[i][2], colors[i][3], colors[i][4]*galpha, r+outline_thickness+(steps-i), 90, .25, 1)

            renderer.rectangle(pos.x + size.x + i - 1, pos.y + r, 1, size.y - 2*r, colors[steps-i+1][1], colors[steps-i+1][2], colors[steps-i+1][3], colors[steps-i+1][4]*galpha)
            renderer.rectangle(pos.x - i, pos.y + r, 1, size.y - 2*r, colors[steps-i+1][1], colors[steps-i+1][2], colors[steps-i+1][3], colors[steps-i+1][4]*galpha)

            renderer.rectangle(pos.x + r, pos.y - i, size.x - 2*r, 1, colors[steps-i+1][1], colors[steps-i+1][2], colors[steps-i+1][3], colors[steps-i+1][4]*galpha)
            renderer.rectangle(pos.x + r, pos.y + size.y + i - 1, size.x - 2*r, 1, colors[steps-i+1][1], colors[steps-i+1][2], colors[steps-i+1][3], colors[steps-i+1][4]*galpha)
        end
    end

    if pos.x ~= pos.x+size.x then
        renderer.rectangle(pos.x + r, pos.y, size.x - 2*r, size.y, color[1], color[2], color[3], color[4]*galpha)
        renderer.rectangle(pos.x + size.x - r, pos.y + r, r, size.y - 2*r, color[1], color[2], color[3], color[4]*galpha)
        renderer.rectangle(pos.x, pos.y + r, r, size.y - 2*r, color[1], color[2], color[3], color[4]*galpha)
    end

    renderer.circle(pos.x + r, pos.y + r, color[1], color[2], color[3], color[4]*galpha, r, 180, .25)
    renderer.circle(pos.x + size.x - r, pos.y + r, color[1], color[2], color[3], color[4]*galpha, r, 90, .25)
    renderer.circle(pos.x + size.x - r, pos.y + size.y - r, color[1], color[2], color[3], color[4]*galpha, r, 0, .25)
    renderer.circle(pos.x + r, pos.y + size.y - r, color[1], color[2], color[3], color[4]*galpha, r, 270, .25)

    if outline and outline.color and outline.thickness then
        renderer.rectangle(pos.x + r, pos.y - outline.thickness, size.x - 2*r, outline.thickness, outline.color[1], outline.color[2], outline.color[3], outline.color[4]*galpha)

        if r > 0 then
            renderer.circle_outline(pos.x + r, pos.y + r, outline.color[1], outline.color[2], outline.color[3], outline.color[4]*galpha, r+outline.thickness, 180, .25, outline.thickness)
            renderer.circle_outline(pos.x + size.x - r, pos.y + r, outline.color[1], outline.color[2], outline.color[3], outline.color[4]*galpha, r+outline.thickness, 270, .25, outline.thickness)
        end

        local dec_color = {
            outline.color[1] - (outline.color[1]/100 * 50),
            outline.color[2] - (outline.color[2]/100 * 50),
            outline.color[3] - (outline.color[3]/100 * 50)
        }

        local cn = math.min(size.y - 2*r, r*6)

        renderer.gradient(pos.x + size.x, pos.y + r, outline.thickness, cn, outline.color[1], outline.color[2], outline.color[3], outline.color[4]*galpha, dec_color[1], dec_color[2], dec_color[3], 0, false)
        renderer.gradient(pos.x - outline.thickness, pos.y + r, outline.thickness, cn, outline.color[1], outline.color[2], outline.color[3], outline.color[4]*galpha, dec_color[1], dec_color[2], dec_color[3], 0, false)
    end
end

-- Common functions
local function get_attachment_vector(world_model)
    local me = entity.get_local_player()
    local wpn = entity.get_player_weapon(me)

    if me == nil or wpn == nil then
        return
    end

    local model = world_model and
        entity.get_prop(wpn, 'm_hWeaponWorldModel') or
        entity.get_prop(me, 'm_hViewModel[0]')

    if me == nil or wpn == nil or model == nil then
        return
    end

    local active_weapon = get_client_entity(wpn)
    local g_model = get_client_entity(model)

    if active_weapon == nil or g_model == nil then
        return
    end

    local attachment_vector = ffi.new 'float[3]'
    local att_index = world_model and
        get_muzzle_attachment_index_3rdperson(active_weapon) or
        get_muzzle_attachment_index_1stperson(active_weapon, g_model)

    if att_index > 0 and get_attachment(g_model, att_index, attachment_vector) then
        return { attachment_vector[0], attachment_vector[1], attachment_vector[2] }
    end
end

local function map_linear(value, in_from, in_to, out_from, out_to)
    return out_from + (value - in_from) * (out_to - out_from) / (in_to - in_from)
end

-- Other functions
local function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end

local function normalize(angle)
    while angle > 180 do angle = angle - 360 end
    while angle < -180 do angle = angle + 360 end

    return angle
end

local function is_in_thirdperson()
    local me = entity.get_local_player()

    if me == nil or not entity.is_alive(me) then
        return false
    end

    return ui.get(thirdperson[1]) and ui.get(thirdperson[2])
end

local function is_viewmodel_visible()
    if is_in_thirdperson() then
        return true
    end

    return should_draw_viewmodel(client_mode)
end

-- Interface
local rsrc_loc = { 'lua', 'b' }
local perspective_list, last_perspective = { 'First person', 'Third person' }

local master_switch = ui.new_checkbox('AA', 'Other', 'Attachment panel')
local accent_color = ui.new_color_picker('AA', 'Other', 'Panel accent color', 25, 25, 176, 255)
local perspective = ui.new_multiselect('AA', 'Other', 'Perspective mode', perspective_list)
local link_to_muzzle = ui.new_combobox('AA', 'Other', 'Link to the muzzle', { 'Off', 'Line', 'Glow line' })
local muzzle_color = ui.new_color_picker('AA', 'Other', 'Panel muzzle color', 34, 43, 113, 255)

-- Resource manager
local resource_manager = ui.new_checkbox(rsrc_loc[1], rsrc_loc[2], 'Attachment panel editor')
local resources = {
    blur = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Panorama blur factor \n atpn', 0, 50, 25, true, 'x', .1, { [0] = 'Off' }),
    blur_alpha = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Panorama blur alpha \n atpn', 0, 100, 100, true, '%', 1, { [0] = 'Off' }),

    smoothing = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Smoothing \n atpn', 50, 200, 100, true, '', .01),
    y_jiggle_factor = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Y Jiggle factor \n atpn', 0, 100, 35),
    z_jiggle_factor = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Z Jiggle factor \n atpn', 0, 100, 40),

    -- label1 = ui.new_label(rsrc_loc[1], rsrc_loc[2], '\n label1'),
    panel_switch_factor = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Panel side switch factor \n atpn', 0, 151, 100, true, '%', 1, { [151] = '∞' }),
    panel_lean_offset = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Panel lean offset \n atpn', 0, 256, 45, true, 'px'),
    panel_lean_angle = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Panel lean angle \n atpn', 0, 360, 45, true, '°'),
    panel_3rd_person = ui.new_combobox(rsrc_loc[1], rsrc_loc[2], 'Panel 3rd person position \n atpn', { '-', 'Left', 'Right' }),

    -- label2 = ui.new_label(rsrc_loc[1], rsrc_loc[2], '\n label2'),
    background_clr_label = ui.new_label(rsrc_loc[1], rsrc_loc[2], 'Background color \n atpn'),
    background_clr = ui.new_color_picker(rsrc_loc[1], rsrc_loc[2], 'bg_color \n atpn', 13, 13, 13, 125),
    roundness = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Panel roundness \n atpn', 0, 15, 6),
    outline_thickness = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Panel outline thickness \n atpn', 0, 8, 2),

    -- label3 = ui.new_label(rsrc_loc[1], rsrc_loc[2], '\n label3'),
    shadow_clr_label = ui.new_label(rsrc_loc[1], rsrc_loc[2], 'Shadow color \n atpn'),
    shadow_clr = ui.new_color_picker(rsrc_loc[1], rsrc_loc[2], 'shadow_clr \n atpn', 23, 40, 125, 255),
    shadow_steps = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Shadow steps \n atpn', 1, 32, 9),
    shadow_range = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Shadow range \n atpn', 0, 100, 25, true, '', .01),

    -- label4 = ui.new_label(rsrc_loc[1], rsrc_loc[2], '\n label4'),
    glow_line_step = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Glow line step \n atpn', 2, 48, 6),
    glow_line_width = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Glow line width [*fps] \n atpn', 1, 16, 8),
    glow_line_clr_interp = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Glow line color interpolation [*fps] \n atpn', 2, 256, 32),
    glow_line_pulse_speed = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Glow line pulse speed \n atpn', 0, 500, 0, true, '', .01, { [0] = 'Off' }),
}

local copy_preset = ui.new_button(rsrc_loc[1], rsrc_loc[2], 'Copy preset', function()
    local preset = {
        _accent_color = { ui.get(accent_color) },
        _link_to_muzzle = { ui.get(link_to_muzzle) },
        _muzzle_color = { ui.get(muzzle_color) }
    }

    for name, val in pairs(resources) do
        preset[name] = { ui.get(val) }
    end

    preset._SETINFO = 1

    local preset_string = base64.encode(json.stringify(preset))

	set_clipboard_text(preset_string, string.len(preset_string))

    local r, g, b = ui.get(accent_color)

    client.color_log(r, g, b, '[Attachment Panel] \0')
    client.color_log(255, 255, 255, 'Successfully copied preset')
end)

local paste_preset = ui.new_button(rsrc_loc[1], rsrc_loc[2], 'Paste preset', function()
    local success, preset = pcall(function()
        local len = get_clipboard_text_count()

        if len > 0 then
            local char_arr = new_char_arr(len)

            get_clipboard_text(0, char_arr, len)

            local clipboard = ffi.string(char_arr, len-1)

            local base64_decoded = base64.decode(clipboard)
            local preset = json.parse(base64_decoded)

            if preset._SETINFO == 1 then
                return preset
            end
        end
    end)

    if preset == nil or success == false then
        error('[Attachment Panel] Invalid preset', 2)
    end

    local crsc = resources

    crsc._accent_color = accent_color
    crsc._link_to_muzzle = link_to_muzzle
    crsc._muzzle_color = muzzle_color

    for name, val in pairs(crsc) do
        if  preset[name] ~= nil and
            type(preset[name]) == 'table'
        then
            ui.set(val, unpack(preset[name]))
        end
    end

    local r, g, b = ui.get(accent_color)

    client.color_log(r, g, b, '[Attachment Panel] \0')
    client.color_log(255, 255, 255, 'Successfully pasted preset')

    client.reload_active_scripts()
end)

-- Root Function
local blur = create_blur_instance()
local panel_side, panel_side_cache = true
local text_clr = interpolate_colors_range(
    { 255, 255, 255, 0 },
    { 235, 95, 135, 0 }, 10
)

local shifting_data = { 0, 0 }
local dir_data = {
    yaw = false,
    pitch = false,
    difference = 0,

    directions = vector(0, 0, 0),
    y_vector = vector(0, 1, 0),
    z_vector = vector(0, 0, 1)
}

local tween_list = { }
local tween_data = {
    panel_smoothing_x = 0,
    panel_smoothing_y = 0,
    panel_side = 0,

    exp_smoothing = 0,
    tickbase = 0,

    body_yaw = 0,
    real_overlap = 1,
    opposite_overlap = 1
}

local function check_3rdp(thirdperson, value)
    if value ~= '-' then
        if thirdperson then
            if panel_side_cache == nil then
                panel_side_cache, panel_side =
                    panel_side,
                    value == 'Right'
            end
        else
            if panel_side_cache ~= nil then
                panel_side, panel_side_cache =
                    panel_side_cache, nil
            end
        end
    end
end

local function handle_attachment(me, muzzle)
    if me == nil or not entity.is_alive(me) or muzzle == nil then
        return
    end

    local perspective = ui.get(perspective)
    local thirdperson = is_in_thirdperson()
    local scoreboard = get_scoreboard()
    local direction = dir_data.directions

    if  not is_viewmodel_visible() or (scoreboard ~= nil and scoreboard.visible) or
        (not contains(perspective, perspective_list[1]) and not thirdperson) or
        (not contains(perspective, perspective_list[2]) and thirdperson)
    then
        return
    end

    local muzzle_w2s = {
        renderer.world_to_screen(
            muzzle[1],
            muzzle[2],
            muzzle[3]
        )
    }

    if muzzle_w2s[1] == nil or muzzle_w2s[2] == nil then
        return
    end

    local lean_angle = math.rad(ui.get(resources.panel_lean_angle))
    local jiggle = { ui.get(resources.y_jiggle_factor), ui.get(resources.z_jiggle_factor) }

    local up_dir = thirdperson and 0 or -jiggle[2]
    local right_dir = thirdperson and -jiggle[1]/2 or -jiggle[1]
    local lean =
        vector(
            math.cos(lean_angle),
            math.sin(lean_angle)
        ) * ui.get(resources.panel_lean_offset)

    local absolute_pos = {
        muzzle_w2s[1] + (direction.y * right_dir) + (panel_side and lean.x or -lean.x),
        muzzle_w2s[2] - lean.y - (direction.z * up_dir)
    }

    if tween_list.panel_smoothing == nil then
        tween_data.panel_smoothing_x = absolute_pos[1]
        tween_data.panel_smoothing_y = absolute_pos[2]
    end

    -- [!] Interpolation
    tween_list.panel_smoothing = tween.new(.1, tween_data, {
        panel_smoothing_x = absolute_pos[1],
        panel_smoothing_y = absolute_pos[2]
    })

    return {
        panel = vector(
            tween_data.panel_smoothing_x,
            tween_data.panel_smoothing_y
        ),
        muzzle = vector(muzzle_w2s[1], muzzle_w2s[2])
    }
end

local g_entity_update = function(c)
    if entity.get_local_player() ~= c.id then
        return
    end

    for i=1, #shifting_data do
        shifting_data[i] = i~=#shifting_data and
            shifting_data[i+1] or c.data.shifting.ticks
    end
end

local g_setup_command = function()
    local me = entity.get_local_player()

    if not ui.get(master_switch) or me == nil or not entity.is_alive(me) then
        return false
    end

    local timer = globals.realtime()
    local camera_angles = vector(client.camera_angles())

    if  timer-dir_data.difference > globals.tickinterval()*2 or
        math.abs(timer-dir_data.difference) > 5 then
        dir_data.yaw = false
    end

    if dir_data.pitch == false or dir_data.yaw == false then
        dir_data.pitch = camera_angles.x
        dir_data.yaw = camera_angles.y
    end

    dir_data.difference = timer

    local velocity = vector(entity.get_prop(me, 'm_vecVelocity'))
    local velocity2d = vector(velocity.x, velocity.y, 0):length()

    if velocity == nil then
        return
    end

    local eye_yaw_rad = math.rad(camera_angles.y)
    local eye_yaw_sin = math.sin(eye_yaw_rad)

    local forward_right_angle =
        math.atan2(eye_yaw_sin, math.cos(eye_yaw_rad)) -
        math.atan2(velocity.y, velocity.x)

    local up_angle = math.atan2(camera_angles.y, velocity.z)

    local forward_factor = velocity2d > 0 and math.cos(forward_right_angle) * velocity2d / 250 or 0
    local right_factor = velocity2d > 0 and math.sin(forward_right_angle) * velocity2d / 250 or 0
    local up_factor = math.abs(velocity.z) > 0 and math.cos(up_angle) * math.abs(velocity.z) / 250 or 0

    local vec_camera_prev_yaw = vector():init_from_angles(0, dir_data.yaw)
    local vec_camera_yaw = vector():init_from_angles(0, camera_angles.y)
    local yaw_difference_angle = math.acos(vec_camera_yaw:dot(vec_camera_prev_yaw))
    local vec_camera_yaw_cross = vec_camera_yaw:cross(vec_camera_prev_yaw)

    if vec_camera_yaw_cross:dot(dir_data.z_vector) < 0 then
        yaw_difference_angle = -yaw_difference_angle
    end

    if yaw_difference_angle ~= yaw_difference_angle then
        yaw_difference_angle = 0
    end

    local vec_camera_prev_pitch = vector():init_from_angles(dir_data.pitch, 0)
    local vec_camera_pitch = vector():init_from_angles(camera_angles.x, 0)
    local pitch_difference_angle = math.acos(vec_camera_pitch:dot(vec_camera_prev_pitch))
    local vec_camera_pitch_cross = vec_camera_pitch:cross(vec_camera_prev_pitch)

    if vec_camera_pitch_cross:dot(dir_data.y_vector) < 0 then
        pitch_difference_angle = -pitch_difference_angle
    end

    if pitch_difference_angle ~= pitch_difference_angle then
        pitch_difference_angle = 0
    end

    right_factor = right_factor + yaw_difference_angle * 32.5
    up_factor = up_factor + pitch_difference_angle * 32.5 / .5666

    dir_data.pitch = camera_angles.x
    dir_data.yaw = camera_angles.y

    dir_data.directions = vector(forward_factor, right_factor, up_factor)
end

local g_paint_handler = function()
    -- begin again.....
    local me = entity.get_local_player()

    if not ui.get(master_switch) or me == nil or not entity.is_alive(me) then
        return
    end

    local frame = globals.frametime() * (ui.get(resources.smoothing)*.01)

    -- Run attachment handle
    local handle = handle_attachment(me, (function()
        if is_in_thirdperson() then
            return { entity.hitbox_position(me, 2) }
        end

        return get_attachment_vector()
    end)())

    for tname, thandle in pairs(tween_list) do
        thandle:update(frame)

        if handle == nil then
            tween_list[tname] = nil
        end
    end

    if handle == nil then
        dir_data.pitch = false
        dir_data.yaw = false

        return
    end

    -- Panel position & size
    local size = vector(130, 52, ui.get(resources.roundness))

    size.y = size.y + tween_data.exp_smoothing * 12 -- Exploiting Indicator
    size.y = size.y + size.z / 2.5 -- Roundness

    local position = vector(
        handle.panel.x - tween_data.panel_side,
        handle.panel.y - size.y
    )

    local background_color = { ui.get(resources.background_clr) }
    local shadow_color = { ui.get(resources.shadow_clr) }
    local muzzle_line = ui.get(link_to_muzzle)

    local thirdperson = is_in_thirdperson()
    local camera_angles = vector(client.camera_angles())

    local shifting = anti_aim.get_command(me, 'shifting')
    local shifting_ticks = math.max(unpack(shifting_data))

    if shifting_ticks <= 6 then
        shifting_ticks = 0
    end

    -- Important tweening stuff
    tween_list.tickbase = tween.new(.105, tween_data, { tickbase = shifting_ticks })
    tween_list.exp_smoothing = tween.new(.1, tween_data, { exp_smoothing = shifting_ticks > 0 and 1 or 0 })
    tween_list.panel_side = tween.new(.15, tween_data, { panel_side = panel_side and 0 or size.x })

    tween_list.overlap = tween.new(.05, tween_data, {
        body_yaw = math.abs(anti_aim.get_desync(1)),

        real_overlap = anti_aim.get_overlap(false),
        opposite_overlap = anti_aim.get_overlap(true)
    })

    -- Link to the attachment
    if muzzle_line ~= 'Off' then
        local r, g, b, a = ui.get(muzzle_color)
        local glow_interp = ui.get(resources.glow_line_clr_interp)

        if muzzle_line == 'Glow line' then
            renderer_glow_line(
                handle.muzzle, handle.panel,
                { r, g, b, a }, shadow_color, glow_interp,
                ui.get(resources.glow_line_width), ui.get(resources.glow_line_step),
                ui.get(resources.glow_line_pulse_speed) *.01
            )
        else
            local center, center_lerp =
                handle.muzzle:lerp(handle.panel, .5),
                handle.muzzle:lerp(handle.panel, .49)

            renderer_line_gradient(handle.muzzle, center, { r, g, b, 0 }, { r, g, b, a }, glow_interp)
            renderer_line_gradient(center_lerp, handle.panel, { r, g, b, a }, { shadow_color[1], shadow_color[2], shadow_color[3], 0 }, glow_interp)
        end
    end

    check_3rdp(thirdperson, ui.get(resources.panel_3rd_person))

    if not thirdperson then
        local PSF = ui.get(resources.panel_switch_factor)

        local switch_limit_mpl = PSF > 150 and math.huge or PSF * .01
        local limit_left = position.x + size.x / 2 - size.x * switch_limit_mpl
        local limit_right = position.x + size.x / 2 + size.x * switch_limit_mpl

        if handle.muzzle.x > limit_right and panel_side then
            panel_side = false
        end

        if handle.muzzle.x < limit_left and not panel_side then
            panel_side = true
        end
    end

    renderer_rounded_rect({
        position = position,
        size = size,
        roundness = size.z,
        color = background_color,
        outline = { thickness = ui.get(resources.outline_thickness), color = { ui.get(accent_color) } },
        shadow = { steps = ui.get(resources.shadow_steps), range = ui.get(resources.shadow_range)*.01, color = shadow_color }
    })

    blur:renderer_rect(
        position, size,
        ui.get(resources.blur)*.1,
        ui.get(resources.blur_alpha)*.01
    )

    -- size.z is used for rounding
    local roundness = math.max(size.z or 4, 4)

    -- Top-Right Indicators
    -- Anti-aim rotation
    local radius = 8
    local circle_position = vector(
        position.x + size.x - roundness/2 - radius - 6,
        position.y + roundness/2 + radius + 6
    )

    local real_rotation = normalize(camera_angles.y - anti_aim.get_body_yaw(1) - 120)
    local fake_rotation = normalize(camera_angles.y - anti_aim.get_body_yaw(2) - 120)

    renderer.circle_outline(circle_position.x, circle_position.y, 15, 15, 15, 125, radius, 0, 1, 2)
    renderer.circle_outline(circle_position.x, circle_position.y, 150, 150, 150, 220, radius, real_rotation, .1, 2)
    renderer.circle_outline(circle_position.x, circle_position.y, 45, 220, 220, 255, radius, fake_rotation, .1, 2)

    -- On shot anti-aim
    local osaa_position = vector(
        circle_position.x + radius,
        circle_position.y + (radius*2) + 4
    )

    local osaa = ui.get(onshot_aa[1]) and ui.get(onshot_aa[2])
    local osaa_text = osaa and '\a00FF00FFON' or '\aFF0000FFOFF'

    if shifting_ticks > 0 and osaa then
        osaa_text = '\aFF7D5FFFWAIT'
    end

    renderer.text(osaa_position.x, osaa_position.y, 255, 255, 255, 255, '-r', nil, 'OSAA: ', osaa_text)

    -- Left indicators
    local offset = vector(roundness / 2, roundness / 2)

    renderer.text(position.x + offset.x + 1, position.y + offset.y + 1, 255, 255, 255, 255, '-', nil, 'ANTI-AIMBOT DEBUG')

    offset.y = offset.y + 18

    -- FAKE Indications
    local body_yaw = tween_data.body_yaw
    local r, g, b = get_color(body_yaw, 30)
    local ar, ag, ab =
        r - (r/100 * 50),
        g - (g/100 * 50),
        b - (b/100 * 50)

    local text = ('FAKE (%.1f°)'):format(body_yaw)
    local text_size = vector(renderer.measure_text('', text))

    local gradient_seg = text_size.y / 2
    renderer.gradient(position.x + offset.x + 3, position.y + offset.y, 2, gradient_seg, ar, ag, ab, 0, r, g, b, 255, false)
    renderer.gradient(position.x + offset.x + 3, position.y + offset.y + gradient_seg, 2, gradient_seg, r, g, b, 255, ar, ag, ab, 0, false)

    renderer.text(position.x + offset.x + 9, position.y + offset.y, 255, 255, 255, 255, '', nil, text)

    offset.y = offset.y + 16

    -- Anti-aim overlap
    local text = 'SP: '
    local text_size = vector(renderer.measure_text('-', text))

    renderer.text(position.x + offset.x + 9, position.y + offset.y, 255, 255, 255, 255, '-', nil, text)

    local overlap = {
        real = {
            background = {
                position = vector(
                    position.x + offset.x + 9 + text_size.x + 3,
                    position.y + offset.y + 3
                ),

                roundness = 1,
                color = { 15, 15, 15, 220 },
                size = vector(20, 6)
            },

            accent = {
                position = vector(
                    position.x + offset.x + 9 + text_size.x + 4,
                    position.y + offset.y + 4
                ),

                roundness = 1,
                color = { 127, 153, 255, 255 },
                size = vector((18-tween_data.real_overlap*18)+.5, 4)
            }
        },

        opposite = {
            background = {
                position = vector(
                    position.x + offset.x + 9 + text_size.x + 3 + 22,
                    position.y + offset.y + 3
                ),

                roundness = 1,
                color = { 15, 15, 15, 220 },
                size = vector(20, 6)
            },

            accent = {
                position = vector(
                    position.x + offset.x + 9 + text_size.x + 4 + 22,
                    position.y + offset.y + 4
                ),

                roundness = 1,
                color = { 127, 153, 255, 255 },
                size = vector((18-tween_data.opposite_overlap*18)+.5, 4)
            }
        }
    }

    renderer_rounded_rect(overlap.real.background)
    renderer_rounded_rect(overlap.real.accent)

    renderer_rounded_rect(overlap.opposite.background)
    renderer_rounded_rect(overlap.opposite.accent)

    offset.y = offset.y + tween_data.exp_smoothing*13

    if shifting ~= nil and tween_data.exp_smoothing >= .685 then
        local text = 'EXPLOITING'
        local shadow = math.sin(globals.realtime() * 3) / 2 + .5

        local alpha = map_linear(tween_data.exp_smoothing, .685, 1, 0, 1)
        local tickbase_bar = math.min(1, tween_data.tickbase/shifting.ticks_allowed) * 23

        local bar = {
            background = {
                alpha = alpha * 255,
                position = vector(
                    osaa_position.x - 36 + 2,
                    position.y + offset.y + 2
                ),

                roundness = 1,
                color = { 15, 15, 15, 220 },
                size = vector(24, 6),

                shadow = {
                    steps = 4,
                    range = shadow * .2,
                    color = { 185, 15, 15, 255 }
                }
            },

            accent = {
                alpha = alpha * 255,
                position = vector(
                    osaa_position.x - 36 + 3,
                    position.y + offset.y + 3
                ),

                roundness = 1,
                color = { 127, 153, 255, 220 },
                size = vector(math.floor(tickbase_bar), 4)
            }
        }

        local text_clr = text_clr[math.max(1, math.min(10, shifting.no_entry))]

        renderer.text(position.x + offset.x + 9, position.y + offset.y, text_clr[1], text_clr[2], text_clr[3], alpha*220, '-', nil, text)
        renderer.text(osaa_position.x - 36 + 24 + 4, position.y + offset.y, 255, 255, 255, alpha*220, '-', nil, shifting_ticks)

        renderer_rounded_rect(bar.background)
        renderer_rounded_rect(bar.accent)
    end
end

client.set_event_callback('entity_update', g_entity_update)
client.set_event_callback('setup_command', g_setup_command)
client.set_event_callback('paint', g_paint_handler)

-- Set Defaults
ui.set(resources.panel_3rd_person, 'Right')
ui.set(perspective, perspective_list)
ui.set(link_to_muzzle, 'Glow line')

-- UI Callbacks / etc
local main_function_callback = function()
    local active = ui.get(master_switch)
    local editor = active and ui.get(resource_manager)
    local muzzle = active and editor and ui.get(link_to_muzzle) ~= 'Off'

    local glow_vars = {
        'glow_line_step', 'glow_line_width',
        'glow_line_clr_interp', 'glow_line_pulse_speed'
    }

    ui.set_visible(perspective, active)
    ui.set_visible(link_to_muzzle, active)
    ui.set_visible(muzzle_color, active and ui.get(link_to_muzzle) ~= 'Off')

    ui.set_visible(resource_manager, active)
    ui.set_visible(copy_preset, active)
    ui.set_visible(paste_preset, active)

    for name, var in pairs(resources) do
        -- idfk why it doesnt work with ([] and muzzle or editor)
        if contains(glow_vars, name) then
            ui.set_visible(var, muzzle)
        else
            ui.set_visible(var, editor)
        end
    end
end

local pfunc = function()
    if #ui.get(perspective) == 0 then
        ui.set(perspective, perspective_list)
    end
end

client.delay_call(0, function()
    main_function_callback()
    pfunc()
end)

ui.set_callback(master_switch, main_function_callback)
ui.set_callback(perspective, main_function_callback)
ui.set_callback(link_to_muzzle, main_function_callback)
ui.set_callback(resource_manager, main_function_callback)
ui.set_callback(perspective, function(c)
    local list = ui.get(c)

    if last_perspective ~= nil and #list == 0 and #last_perspective == 1 then
        ui.set(c, last_perspective)
        return
    end

    pfunc()

    last_perspective = list
end)