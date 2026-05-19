-- local variables for API functions. any changes to the line below will be lost on re-generation
local assert, bit_band, entity_get_local_player, entity_get_origin, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_is_alive, entity_is_dormant, globals_curtime, globals_tickcount, globals_tickinterval, math_abs, math_floor, math_fmod, math_max, math_min, math_pow, pairs, setmetatable, unpack = assert, bit.band, entity.get_local_player, entity.get_origin, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.is_alive, entity.is_dormant, globals.curtime, globals.tickcount, globals.tickinterval, math.abs, math.floor, math.fmod, math.max, math.min, math.pow, pairs, setmetatable, unpack

local ffi = require 'ffi'
local vector = require 'vector'

-- FFI Related stuff
local class_ptr = ffi.typeof('void***')
local char_ptr = ffi.typeof('char*')
local nullptr = ffi.new('void*')

local jmp_edx = client.find_signature('engine.dll', '\xFF\xE2')

local vtable_bind, vtable_thunk, vtable_thunk_e = (function()
    -- code optimizer compatibility / etc
    return 
        vtable_bind, vtable_thunk,
        function(index, typestring)
            local t = ffi.typeof(typestring)
            return function(instance, ...)
                assert(instance ~= nil)
                if instance then
                    return ffi.cast(t, jmp_edx)(instance, ffi.cast('void***', instance)[0][index], ...)
                end
            end
        end
end)()

local get_max_speed = vtable_thunk(441, 'float(__thiscall*)(void*)')
local estimate_abs_velocity = vtable_thunk_e(144, 'void(__fastcall*)(void*, void*, float*)')

local get_client_networkable = vtable_bind('client.dll', 'VClientEntityList003', 0, 'void*(__thiscall*)(void*, int)')
local get_client_entity = vtable_bind('client.dll', 'VClientEntityList003', 3, 'void*(__thiscall*)(void*, int)')
local get_client_unknown = vtable_thunk(0, 'void*(__thiscall*)(void*)')
local get_client_renderable = vtable_thunk(5, 'void*(__thiscall*)(void*)')

local get_studio_model = vtable_bind('engine.dll', 'VModelInfoClient004', 32, 'void*(__thiscall*)(void*, const void*)')
local get_rmodel = vtable_thunk(8, 'const void*(__thiscall*)(void*)')

local get_sequence_activity = ffi.cast(
	'int(__fastcall*)(void*, void*, int)',
	client.find_signature('client.dll','\x55\x8B\xEC\x53\x8B\x5D\x08\x56\x8B\xF1\x83')
)

local animation_layer_t = ffi.typeof([[
	struct {										char pad_0x0000[0x18];
		uint32_t	sequence;
		float		prev_cycle;
		float		weight;
		float		weight_delta_rate;
		float		playback_rate;
		float		cycle;
		void		*entity;						char pad_0x0038[0x4];
	} **
]])

local animation_state_t = ffi.typeof([[
	struct {										char pad_0x0000[0x18];
		float		anim_update_timer;				char pad_0x001C[0xC];
		float		started_moving_time;
		float		last_move_time;					char pad_0x0030[0x10];
		float		last_lby_time;					char pad_0x0044[0x8];
		float		run_amount;						char pad_0x0050[0x10];
		void*		entity;
		void*		active_weapon;
		void*		last_active_weapon;
		float		last_client_side_animation_update_time;
		int			last_client_side_animation_update_framecount;
		float		eye_timer;
		float		eye_angles_y;
		float		eye_angles_x;
		float		goal_feet_yaw;
		float		current_feet_yaw;
		float		torso_yaw;
		float		last_move_yaw;
		float		lean_amount; char pad2[4];
		float		feet_cycle;
		float		feet_yaw_rate; char pad3[4];
		float		duck_amount;
		float		landing_duck_amount; char pad4[4];
		float		current_origin[3];
		float		last_origin[3];
		float		velocity_x;
		float		velocity_y; char pad5[4];
		float		unknown_float1; char pad6[8];
		float		unknown_float2;
		float		unknown_float3;
		float		unknown;
		float		m_velocity;
		float		jump_fall_velocity;
		float		clamped_velocity;
		float		feet_speed_forwards_or_sideways;
		float		feet_speed_unknown_forwards_or_sideways;
		float		last_time_started_moving;
		float		last_time_stopped_moving;
		bool		on_ground;
		bool		hit_in_ground_animation; char pad7[4];
		float		time_since_in_air;
		float		last_origin_z;
		float		head_from_ground_distance_standing;
		float		stop_to_full_running_fraction;		char		pad8[4];
		float		magic_fraction;						char		pad9[60];
		float		world_force;						char		pad10[458];
		float		min_yaw;
		float		max_yaw;
	} **
]])

-- ConVars / etc
local process_ticks = cvar.sv_maxusrcmdprocessticks

-- Anti-aim stuff metatable
local antiaim_mt = { }
local antiaim_mt_data = {
    initialized = false,
    abs_vel = ffi.new('float[3]'),

    eye_angles_y = nil,
    srv_goal_feet_yaw = nil,

    speed = 0,
    duck_amount = 0,
    stop_to_full_running_fraction = 0,

    abs_yaw = 0,
    feet_yaw = 0,
    server_feet_yaw = 0,
    desync_exact = 0,
    desync = 0,

    balance_adjust = {
        updating = false,
        next_update = 0
    }
}

antiaim_mt.clamp = function(self, val, min_val, max_val)
    return math_max(min_val, math_min(max_val, val))
end

antiaim_mt.normalize = function(self, angle)
    while angle > 180 do 
        angle = angle - 360
    end

    while angle < -180 do
        angle = angle + 360
    end

    return angle
end

antiaim_mt.anglemod = function(self, a)
    return (360 / 65536) * bit_band(math_floor(a * (65536 / 360)), 65535)
end

antiaim_mt.angle_diff = function(self, dest_angle, src_angle)
    local delta = math_fmod(dest_angle - src_angle, 360)
    if dest_angle > src_angle then
        if delta >= 180 then
            delta = delta - 360
        end
    else
        if delta <= -180 then
            delta = delta + 360
        end
    end
    return delta
end

antiaim_mt.approach_angle = function(self, target, value, speed)
    target = self:anglemod(target)
    value = self:anglemod(value)

    local delta = target - value

    if speed < 0 then
        speed = -speed
    end

    if delta < -180 then
        delta = delta + 360
    elseif delta > 180 then
        delta = delta - 360
    end

    if delta > speed then
        value = value + speed
    elseif delta < -speed then
        value = value - speed
    else
        value = target
    end

    return value
end

antiaim_mt.get_smoothed_velocity = function(self, min_delta, a, b)
    local delta = a - b
    local delta_length = delta:length()

    if delta_length <= min_delta then
        if -min_delta <= delta_length then
            return a
        else
            local radius = 1 / (delta_length + 1.19209290E-07)
            return b - ((delta * radius) * min_delta)
        end
    else
        local radius = 1 / (delta_length + 1.19209290E-07)
        return b + ((delta * radius) * min_delta)
    end
end

antiaim_mt.get_model = function(self, client_entity)
	local networkable = ffi.cast(class_ptr, get_client_networkable(client_entity))

	if networkable == nullptr then
		return
	end

	local unknown = ffi.cast(class_ptr, get_client_unknown(networkable))

	if unknown == nullptr then
		return
	end

	local renderable = ffi.cast(class_ptr, get_client_renderable(unknown))

	if renderable == nullptr then
		return
	end

	return get_rmodel(renderable)
end

antiaim_mt.get_overlap = function(self, rotation)
    local client, server, lean =
        self.feet_yaw,
        self.server_feet_yaw,
        self:angle_diff(self.abs_yaw, self.feet_yaw)

    if type(rotation) == 'number' then
        local cLean = math_abs(lean)

        client = self:clamp(
            rotation, 
            self.abs_yaw-cLean, self.abs_yaw+cLean
        )
    end

    if rotation == true then
        client = self.abs_yaw + lean
    end

    local adiff = math_abs(self:angle_diff(client, server))

    return 1 - (adiff / 120 * 1), client
end

antiaim_mt.createmove = function(self, c)
	local local_player = entity_get_local_player()

	if local_player == nil then
		return
	end

    local local_player_ent = get_client_entity(local_player)

    if local_player_ent == nil then
        return
    end

    local local_player_ptr = ffi.cast(class_ptr, local_player_ent)

    if local_player_ptr == nullptr then
        return
    end

	local hdr = get_studio_model(self:get_model(local_player))

	if hdr == -1 then
		return
	end

	local tickinterval = globals_tickinterval()
    
    local anim_state = ffi.cast(
        animation_state_t, 
        ffi.cast(char_ptr, local_player_ptr) + 0x3914
    )[0]

    if not self.initialized then
        self.original_data = self.data
        self.initialized = true
    end

	if anim_state.anim_update_timer <= 0.0 then
		self.stop_to_full_running_fraction, self.duck_amount, self.speed = 0, 0, 0
		self.eye_angles_y, self.srv_goal_feet_yaw = nil, nil
		self.data = self.original_data
		return
	end

	if self.eye_angles_y == nil or self.srv_goal_feet_yaw == nil then
		self.eye_angles_y = anim_state.eye_angles_y
		self.srv_goal_feet_yaw = anim_state.goal_feet_yaw
	end

	if c.chokedcommands == 0 then
		self.stop_to_full_running_fraction = anim_state.stop_to_full_running_fraction
		self.duck_amount = anim_state.duck_amount
		self.eye_angles_y = anim_state.eye_angles_y

		estimate_abs_velocity(local_player_ent, self.abs_vel)

		local velocity_a = vector(self.abs_vel[0], self.abs_vel[1], self.abs_vel[2])
		local velocity_b = vector(entity_get_prop(local_player, 'm_vecVelocity'))

		local spd = velocity_a:lengthsqr()

		if spd > math_pow(1.2 * 260, 2) then
			local velocity_normalized = velocity_a:normalized()
			velocity_a = velocity_normalized * (1.2 * 260)
		end

		velocity_a.z = 0
		velocity_b = self:get_smoothed_velocity(tickinterval * 2000, velocity_a, velocity_b)

		self.speed = math_min(velocity_b:length(), 260)
	end

	local weapon = entity_get_player_weapon(local_player)
	local max_movement_speed = weapon and math_max(
        get_max_speed(ffi.cast(
            class_ptr, 
            get_client_entity(weapon)
        )), 0.001
    ) or 260

	local running_speed = self:clamp(self.speed / (max_movement_speed * 0.520), 0, 1)
	local yaw_modifier = (((self.stop_to_full_running_fraction * -0.3) - 0.2) * running_speed) + 1

	if self.duck_amount > 0 then
		local ducking_speed = self:clamp(self.speed / (max_movement_speed * 0.340), 0, 1)
		yaw_modifier = yaw_modifier + ((self.duck_amount * ducking_speed) * (0.5 - yaw_modifier))
	end

	self.srv_goal_feet_yaw = self:clamp(self.srv_goal_feet_yaw, -360, 360)

	local eye_feet_delta = self:angle_diff(self.eye_angles_y, self.srv_goal_feet_yaw)
	local max_yaw_modifier, min_yaw_modifier = 
		yaw_modifier * 58,
		yaw_modifier * -58

	if eye_feet_delta <= max_yaw_modifier then
		if min_yaw_modifier > eye_feet_delta then
			self.srv_goal_feet_yaw = math_abs(min_yaw_modifier) + self.eye_angles_y
		end
	else
		self.srv_goal_feet_yaw = self.eye_angles_y - math_abs(max_yaw_modifier)
	end

	if self.speed > 0.1 then
		self.srv_goal_feet_yaw = self:approach_angle(
			self.eye_angles_y,
			self:normalize(self.srv_goal_feet_yaw),
			((self.stop_to_full_running_fraction * 20) + 30) * tickinterval
		)
	else
		self.srv_goal_feet_yaw = self:approach_angle(
			entity_get_prop(local_player, 'm_flLowerBodyYawTarget'),
			self:normalize(self.srv_goal_feet_yaw), 
			tickinterval * 100
		)
	end

    local curtime = globals_curtime()
	local lower_body = ffi.cast(
        animation_layer_t, 
        ffi.cast(char_ptr, local_player_ptr) + 0x2980
    )[0][3]

	if not self.balance_adjust.updating then
		self.balance_adjust.next_update = curtime + 0.22
	elseif get_sequence_activity(local_player_ent, hdr, lower_body.sequence) == 979 then
		if self.balance_adjust.next_update < curtime and lower_body.weight > 0.000 then
			self.balance_adjust.next_update = curtime + 1.1
		end
	end

	if c.chokedcommands == 0 then
		local body_lean = math_abs(self:angle_diff(anim_state.eye_angles_y, anim_state.goal_feet_yaw))

		self.balance_adjust.updating = 
			anim_state.on_ground and anim_state.m_velocity < 0.1 and
			anim_state.anim_update_timer > 0.0

        self.abs_yaw = anim_state.eye_angles_y
        self.feet_yaw = anim_state.goal_feet_yaw
        self.server_feet_yaw = self.srv_goal_feet_yaw

        self.desync_exact = self:angle_diff(self.srv_goal_feet_yaw, anim_state.goal_feet_yaw)
        self.desync = self:clamp(self.desync_exact, -body_lean, body_lean)
	end
end

-- Tickbase stuff metatable
local tickbase_mt = { }
local tickbase_mt_data = {
    data = { }
}

tickbase_mt.to_time = function(self, t)
    return t / globals_tickinterval()
end

tickbase_mt.get_tickcount = function(self)
    return self:to_time(globals_curtime())
end

tickbase_mt.get_simtime = function(self, idx)
    if idx == nil then
        return -1
    end

    if entity_get_local_player() == idx then
        -- local client_entity = get_client_entity(id)
        -- local old_sim_time = ffi.cast("float*", ffi.cast("char*", client_entity) + 0x0268 + 4)[0]

        return entity_get_prop(idx, 'm_nTickBase') * globals_tickinterval()
    end

    return entity_get_prop(idx, 'm_flSimulationTime')
end

tickbase_mt.get_lag_buffer = function(self, idx)
    if idx == nil then
        idx = entity_get_local_player()
    end

    if self.data[idx] == nil then
        return
    end

    local buffer = { }
    local index = self.data[idx]
    local deviation = index.deviation

    buffer.teleport = {
        distance = index.teleport,
        origin = index.origin,
        choke = index.choke
    }

    buffer.shifting = {
        ticks_allowed = process_ticks:get_int() - 2,
        ticks = math_abs(deviation > -6 and 0 or deviation),
        
        no_history = math_floor(math_max(
            0, index.zero_history - globals_tickcount()
        ))
    }

    return buffer
end

tickbase_mt.on_net_update = function(self)
    local me = entity_get_local_player()

    if me == nil then
        self.data = { }
        return
    end

    local ticks_allowed, tick =
        process_ticks:get_int(),
        self:get_tickcount()

    for _, id in pairs(entity_get_players()) do
        local origin = vector(entity_get_origin(id))

        local tick_base = self:to_time(self:get_simtime(id))
        local deviation = math_max(-ticks_allowed + 2, math_min(tick_base - tick - 2, 0))

        local lag_data = {
            id = id,
            tick = tick_base,
            deviation = deviation
        }

        if self.data[id] == nil then
            lag_data.teleport = 0
            lag_data.zero_history = 0
            lag_data.origin = origin
            lag_data.choke = 0

            self.data[id] = lag_data
        end
        
        local player = self.data[id]

        if player.tick ~= tick_base then
            local sim_difference = tick_base-player.tick
            local vec = origin-player.origin

            if tick > player.zero_history and sim_difference < 0 then
                lag_data.zero_history = tick - sim_difference
            end

            lag_data.teleport = (origin-player.origin):lengthsqr()
            lag_data.choke = math_max(0, tick_base - player.tick - 1)

            lag_data.origin = origin

            for k, v in pairs(lag_data) do
                self.data[id][k] = v
            end
        end
    end

    for id, ent in pairs(self.data) do
        if not entity_is_alive(id) or entity_is_dormant(id) then
            self.data[id] = nil
            break
        end
    end
end

-- Object creation
local antiaim = setmetatable(antiaim_mt_data, { __index = antiaim_mt })
local tickbase = setmetatable(tickbase_mt_data, { __index = tickbase_mt })

client.set_event_callback('setup_command', function(c) antiaim:createmove(c) end)
client.set_event_callback('net_update_end', function() tickbase:on_net_update() end)

-- Getting things ready
local ret_thing = function(n, ...)
	local type = { }
	local _arr = { ... }

	for i=1, #_arr do
		type[#type+1] = _arr[i]
	end

	if type[n] == nil then
		return unpack(_arr)
	end

	return type[n]
end

return {
	get_abs_yaw = function()
        return antiaim.abs_yaw
    end,

	get_balance_adjust = function()
        return antiaim.balance_adjust
    end,

	get_body_yaw = function(n)
        return ret_thing(n, antiaim.feet_yaw, antiaim.server_feet_yaw)
    end,

	get_desync = function(n)
        return ret_thing(n, antiaim.desync, antiaim.desync_exact)
    end,

	get_overlap = function(rotation)
        return antiaim:get_overlap(rotation)
    end,

    get_lag_buffer = function(idx)
        return tickbase:get_lag_buffer(idx)
    end
}