--
-- Dependencies
--
local ffi = require 'ffi'
local vector = require 'vector'
local anti_aim = require 'gamesense_/antiaim_funcs'
local inspect = require 'gamesense/inspect'

local jmp_edx = client.find_signature('engine.dll', '\xFF\xE2')
local vtable_thunk_e = function(a,b)local c=ffi.typeof(b)return function(d,...)assert(d~=nil)if d then return ffi.cast(c,jmp_edx)(d,ffi.cast(class_ptr,d)[0][a],...)end end end
local tween = (function()local a={}local b,c,d,e,f,g,h=math.pow,math_sin,math_cos,math.pi,math_sqrt,math_abs,math.asin;local function i(j,k,l,m)return l*j/m+k end;local function n(j,k,l,m)return l*b(j/m,2)+k end;local function o(j,k,l,m)j=j/m;return-l*j*(j-2)+k end;local function p(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,2)+k end;return-l/2*((j-1)*(j-3)-1)+k end;local function q(j,k,l,m)if j<m/2 then return o(j*2,k,l/2,m)end;return n(j*2-m,k+l/2,l/2,m)end;local function r(j,k,l,m)return l*b(j/m,3)+k end;local function s(j,k,l,m)return l*(b(j/m-1,3)+1)+k end;local function t(j,k,l,m)j=j/m*2;if j<1 then return l/2*j*j*j+k end;j=j-2;return l/2*(j*j*j+2)+k end;local function u(j,k,l,m)if j<m/2 then return s(j*2,k,l/2,m)end;return r(j*2-m,k+l/2,l/2,m)end;local function v(j,k,l,m)return l*b(j/m,4)+k end;local function w(j,k,l,m)return-l*(b(j/m-1,4)-1)+k end;local function x(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,4)+k end;return-l/2*(b(j-2,4)-2)+k end;local function y(j,k,l,m)if j<m/2 then return w(j*2,k,l/2,m)end;return v(j*2-m,k+l/2,l/2,m)end;local function z(j,k,l,m)return l*b(j/m,5)+k end;local function A(j,k,l,m)return l*(b(j/m-1,5)+1)+k end;local function B(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,5)+k end;return l/2*(b(j-2,5)+2)+k end;local function C(j,k,l,m)if j<m/2 then return A(j*2,k,l/2,m)end;return z(j*2-m,k+l/2,l/2,m)end;local function D(j,k,l,m)return-l*d(j/m*e/2)+l+k end;local function E(j,k,l,m)return l*c(j/m*e/2)+k end;local function F(j,k,l,m)return-l/2*(d(e*j/m)-1)+k end;local function G(j,k,l,m)if j<m/2 then return E(j*2,k,l/2,m)end;return D(j*2-m,k+l/2,l/2,m)end;local function H(j,k,l,m)if j==0 then return k end;return l*b(2,10*(j/m-1))+k-l*.001 end;local function I(j,k,l,m)if j==m then return k+l end;return l*1.001*(-b(2,-10*j/m)+1)+k end;local function J(j,k,l,m)if j==0 then return k end;if j==m then return k+l end;j=j/m*2;if j<1 then return l/2*b(2,10*(j-1))+k-l*.0005 end;return l/2*1.0005*(-b(2,-10*(j-1))+2)+k end;local function K(j,k,l,m)if j<m/2 then return I(j*2,k,l/2,m)end;return H(j*2-m,k+l/2,l/2,m)end;local function L(j,k,l,m)return-l*(f(1-b(j/m,2))-1)+k end;local function M(j,k,l,m)return l*f(1-b(j/m-1,2))+k end;local function N(j,k,l,m)j=j/m*2;if j<1 then return-l/2*(f(1-j*j)-1)+k end;j=j-2;return l/2*(f(1-j*j)+1)+k end;local function O(j,k,l,m)if j<m/2 then return M(j*2,k,l/2,m)end;return L(j*2-m,k+l/2,l/2,m)end;local function P(Q,R,l,m)Q,R=Q or m*.3,R or 0;if R<g(l)then return Q,l,Q/4 end;return Q,R,Q/(2*e)*h(l/R)end;local function S(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m;if j==1 then return k+l end;Q,R,T=P(Q,R,l,m)j=j-1;return-(R*b(2,10*j)*c((j*m-T)*2*e/Q))+k end;local function U(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m;if j==1 then return k+l end;Q,R,T=P(Q,R,l,m)return R*b(2,-10*j)*c((j*m-T)*2*e/Q)+l+k end;local function V(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m*2;if j==2 then return k+l end;Q,R,T=P(Q,R,l,m)j=j-1;if j<0 then return-.5*R*b(2,10*j)*c((j*m-T)*2*e/Q)+k end;return R*b(2,-10*j)*c((j*m-T)*2*e/Q)*.5+l+k end;local function W(j,k,l,m,R,Q)if j<m/2 then return U(j*2,k,l/2,m,R,Q)end;return S(j*2-m,k+l/2,l/2,m,R,Q)end;local function X(j,k,l,m,T)T=T or 1.70158;j=j/m;return l*j*j*((T+1)*j-T)+k end;local function Y(j,k,l,m,T)T=T or 1.70158;j=j/m-1;return l*(j*j*((T+1)*j+T)+1)+k end;local function Z(j,k,l,m,T)T=(T or 1.70158)*1.525;j=j/m*2;if j<1 then return l/2*j*j*((T+1)*j-T)+k end;j=j-2;return l/2*(j*j*((T+1)*j+T)+2)+k end;local function _(j,k,l,m,T)if j<m/2 then return Y(j*2,k,l/2,m,T)end;return X(j*2-m,k+l/2,l/2,m,T)end;local function a0(j,k,l,m)j=j/m;if j<1/2.75 then return l*7.5625*j*j+k end;if j<2/2.75 then j=j-1.5/2.75;return l*(7.5625*j*j+.75)+k elseif j<2.5/2.75 then j=j-2.25/2.75;return l*(7.5625*j*j+.9375)+k end;j=j-2.625/2.75;return l*(7.5625*j*j+.984375)+k end;local function a1(j,k,l,m)return l-a0(m-j,0,l,m)+k end;local function a2(j,k,l,m)if j<m/2 then return a1(j*2,0,l,m)*.5+k end;return a0(j*2-m,0,l,m)*.5+l*.5+k end;local function a3(j,k,l,m)if j<m/2 then return a0(j*2,k,l/2,m)end;return a1(j*2-m,k+l/2,l/2,m)end;a.easing={linear=i,inQuad=n,outQuad=o,inOutQuad=p,outInQuad=q,inCubic=r,outCubic=s,inOutCubic=t,outInCubic=u,inQuart=v,outQuart=w,inOutQuart=x,outInQuart=y,inQuint=z,outQuint=A,inOutQuint=B,outInQuint=C,inSine=D,outSine=E,inOutSine=F,outInSine=G,inExpo=H,outExpo=I,inOutExpo=J,outInExpo=K,inCirc=L,outCirc=M,inOutCirc=N,outInCirc=O,inElastic=S,outElastic=U,inOutElastic=V,outInElastic=W,inBack=X,outBack=Y,inOutBack=Z,outInBack=_,inBounce=a1,outBounce=a0,inOutBounce=a2,outInBounce=a3}local function a4(a5,a6,a7)a7=a7 or a6;local a8=getmetatable(a6)if a8 and getmetatable(a5)==nil then setmetatable(a5,a8)end;for a9,aa in pairs(a6)do if type(aa)=='table'then a5[a9]=a4({},aa,a7[a9])else a5[a9]=a7[a9]end end;return a5 end;local function ab(ac,ad,ae)ae=ae or{}local af,ag;for a9,ah in pairs(ad)do af,ag=type(ah),a4({},ae)table.insert(ag,tostring(a9))if af=='number'then assert(type(ac[a9])=='number','Parameter \''..table.concat(ag,'/')..'\' is missing from subject or isn\'t a number')elseif af=='table'then ab(ac[a9],ah,ag)else assert(af=='number','Parameter \''..table.concat(ag,'/')..'\' must be a number or table of numbers')end end end;local function ai(aj,ac,ad,ak)assert(type(aj)=='number'and aj>0,'duration must be a positive number. Was '..tostring(aj))local al=type(ac)assert(al=='table'or al=='userdata','subject must be a table or userdata. Was '..tostring(ac))assert(type(ad)=='table','target must be a table. Was '..tostring(ad))assert(type(ak)=='function','easing must be a function. Was '..tostring(ak))ab(ac,ad)end;local function am(ak)ak=ak or'linear'if type(ak)=='string'then local an=ak;ak=a.easing[an]if type(ak)~='function'then error('The easing function name \''..an..'\' is invalid')end end;return ak end;local function ao(ac,ad,ap,aq,aj,ak)local j,k,l,m;for a9,aa in pairs(ad)do if type(aa)=='table'then ao(ac[a9],aa,ap[a9],aq,aj,ak)else j,k,l,m=aq,ap[a9],aa-ap[a9],aj;ac[a9]=ak(j,k,l,m)end end end;local ar={}local as={__index=ar}function ar:set(aq)assert(type(aq)=='number','clock must be a positive number or 0')self.initial=self.initial or a4({},self.target,self.subject)self.clock=aq;if self.clock<=0 then self.clock=0;a4(self.subject,self.initial)elseif self.clock>=self.duration then self.clock=self.duration;a4(self.subject,self.target)else ao(self.subject,self.target,self.initial,self.clock,self.duration,self.easing)end;return self.clock>=self.duration end;function ar:reset()return self:set(0)end;function ar:update(at)assert(type(at)=='number','dt must be a number')return self:set(self.clock+at)end;function a.new(aj,ac,ad,ak)ak=am(ak)ai(aj,ac,ad,ak)return setmetatable({duration=aj,subject=ac,target=ad,easing=ak,clock=0},as)end;return a end)()

local bind_list = json.parse '[{"reference":["legit","aimbot","Enabled"],"is_custom":false,"offset":2,"custom_name":"Legit aimbot"},{"reference":["legit","triggerbot","Enabled"],"is_custom":false,"offset":2,"custom_name":"Legit triggerbot"},{"reference":["rage","aimbot","Enabled"],"is_custom":false,"offset":2,"custom_name":"Rage aimbot"},{"reference":["rage","aimbot","Force safe point"],"is_custom":false,"offset":1,"custom_name":"Safe point"},{"reference":["rage","other","Quick stop"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["rage","other","Quick peek assist"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["rage","other","Force body aim"],"is_custom":false,"offset":1,"custom_name":""},{"reference":["rage","other","Duck peek assist"],"is_custom":false,"offset":1,"custom_name":""},{"reference":["rage","other","Double tap"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["rage","other","Anti-aim correction override"],"is_custom":false,"offset":1,"custom_name":"Resolver override"},{"reference":["aa","anti-aimbot angles","Freestanding"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["aa","other","Slow motion"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["aa","other","On shot anti-aim"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["aa","other","Fake peek"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["misc","movement","Z-Hop"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["misc","movement","Pre-speed"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["misc","movement","Blockbot"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["misc","movement","Jump at edge"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["misc","miscellaneous","Last second defuse"],"is_custom":false,"offset":1,"custom_name":""},{"reference":["misc","miscellaneous","Free look"],"is_custom":false,"offset":1,"custom_name":""},{"reference":["misc","miscellaneous","Ping spike"],"is_custom":false,"offset":2,"custom_name":""},{"reference":["misc","miscellaneous","Automatic grenade release"],"is_custom":false,"offset":2,"custom_name":"Grenade release"},{"reference":["visuals","player esp","Activation type"],"is_custom":false,"offset":1,"custom_name":"Visuals"}]'

--
-- Mathematics / Colors
--

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

local function map_linear(value, in_from, in_to, out_from, out_to)
    return out_from + (value - in_from) * (out_to - out_from) / (in_to - in_from)
end

local function to_hex(...)
	local hexadecimal = ''

	for key, value in pairs({ ... }) do
		local hex = ''
		while value > 0 do
			local index = math.fmod(value, 16) + 1

			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex
		end

		if string.len(hex) == 0 then
			hex = '00'
        elseif string.len(hex) == 1 then
			hex = '0' .. hex
		end

		hexadecimal = hexadecimal .. hex
	end

	return hexadecimal
end

local function renderer_text_fix(input, flags, alpha)
    local input = input()
    local hex_color = '\a' .. string.rep('[0-9A-Fa-f]', 8)

    if alpha ~= nil then
        input = input:gsub(hex_color, function(color)
            color = string.sub(color, 2)

            local inverted_color = '\a'

            for i = 0, 3 do
                local component = string.sub(color, 1 + i * 2, 2 + i * 2)

                component = tonumber('0x' .. component)

                if i == 3 then
                    component = (component * alpha) / 255
                end

                inverted_color = inverted_color .. ('%.2x'):format(component)
            end

            return inverted_color
        end)
    end

    return input, vector(renderer.measure_text(flags, input))
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
        local cn = math.min(size.y - 2*r, r*6)
        local rl = ({
            top = {
                rect = { pos.x + r, pos.y - outline.thickness, size.x - 2*r, outline.thickness },
                fade = {
                    [1] = { pos.x + size.x, pos.y + r, outline.thickness, cn },
                    [2] = { pos.x - outline.thickness, pos.y + r, outline.thickness, cn }
                },

                roundess = {
                    [1] = { pos.x + r, pos.y + r, 180 },
                    [2] = { pos.x + size.x - r, pos.y + r, 270 }
                }
            },

            bottom = {
                rect = { pos.x + r, pos.y + size.y, size.x - 2*r, outline.thickness },
                fade = {
                    [1] = { pos.x + size.x, pos.y + size.y - r, outline.thickness, -cn },
                    [2] = { pos.x - outline.thickness, pos.y + size.y - r, outline.thickness, -cn }
                },

                roundess = {
                    [1] = { pos.x + r, pos.y + size.y - r, 90 },
                    [2] = { pos.x + size.x - r, pos.y + size.y - r, 0 }
                }
            },

            left = {
                rect = { pos.x - outline.thickness, pos.y + r, outline.thickness, size.y - 2*r },
                fade = {
                    [1] = { pos.x + r, pos.y - outline.thickness, cn, outline.thickness, true },
                    [2] = { pos.x + r, pos.y + size.y, cn, outline.thickness, true }
                },

                roundess = {
                    [1] = { pos.x + r, pos.y + size.y - r, 90 },
                    [2] = { pos.x + r, pos.y + r, 180 },
                }
            },

            right = {
                rect = { pos.x + size.x, pos.y + r, outline.thickness, size.y - 2*r },
                fade = {
                    [1] = { pos.x + size.x - r, pos.y - outline.thickness, -cn, outline.thickness, true },
                    [2] = { pos.x + size.x - r, pos.y + size.y, -cn, outline.thickness, true }
                },

                roundess = {
                    [1] = { pos.x + size.x - r, pos.y + size.y - r, 0 },
                    [2] = { pos.x + size.x - r, pos.y + r, 270 },
                }
            }
        })[outline.position or 'top']

        if outline.style == 2 then
            local color = outline.color
            local top_or_bottom =
                outline.position == 'bottom' or outline.position == 'top'

            local pos = ({
                [0] = {
                    { rl.rect[1], rl.rect[2] + rl.rect[4] / 2, rl.rect[3], rl.rect[4] / 2 },
                    { rl.rect[1], rl.rect[2], rl.rect[3], rl.rect[4] / 2 }
                },

                [1] = {
                    { rl.rect[1] + rl.rect[3] / 2, rl.rect[2], rl.rect[3] / 2, rl.rect[4] },
                    { rl.rect[1], rl.rect[2], rl.rect[3] / 2, rl.rect[4] }
                }
            })[top_or_bottom and 1 or 0]

            renderer.gradient(
                pos[1][1], pos[1][2], pos[1][3], pos[1][4],

                color[1], color[2], color[3], color[4]*galpha,
                0, 0, 0, color[4]*galpha / 100 * 10*2,

                top_or_bottom
            )

            renderer.gradient(
                pos[2][1], pos[2][2], pos[2][3], pos[2][4],

                0, 0, 0, (color[4]*galpha) / 100 * 10*2,
                color[1], color[2], color[3], color[4]*galpha,

                top_or_bottom
            )
        else
            renderer.rectangle(
                rl.rect[1], rl.rect[2], rl.rect[3], rl.rect[4],
                outline.color[1], outline.color[2], outline.color[3], outline.color[4]*galpha
            )

            if r > 0 and rl.roundess then
                for i=1, #rl.roundess do
                    renderer.circle_outline(rl.roundess[i][1], rl.roundess[i][2], outline.color[1], outline.color[2], outline.color[3], outline.color[4]*galpha, r+outline.thickness, rl.roundess[i][3], .25, outline.thickness)
                end
            end

            if rl.fade then
                local dec_color = {
                    outline.color[1] - (outline.color[1]/100 * 50),
                    outline.color[2] - (outline.color[2]/100 * 50),
                    outline.color[3] - (outline.color[3]/100 * 50)
                }

                for i=1, #rl.fade do
                    renderer.gradient(rl.fade[i][1], rl.fade[i][2], rl.fade[i][3], rl.fade[i][4], outline.color[1], outline.color[2], outline.color[3], outline.color[4]*galpha, dec_color[1], dec_color[2], dec_color[3], 0, rl.fade[i][5] or false)
                end
            end
        end
    end
end

--
-- Common functions
--

local function new_graphics()
    local graphics = {}

    graphics.renderer_line = function(self, pos, size, clr)
        renderer.line(pos.x, pos.y, size.x, size.y, clr.r, clr.g, clr.b, clr.a)
    end

    graphics.renderer_rectangle_outlined = function(self, pos, size, clr)
        renderer.line(pos.x, pos.y, pos.x, size.y, clr.r, clr.g, clr.b, clr.a)
        renderer.line(pos.x, pos.y, size.x, pos.y, clr.r, clr.g, clr.b, clr.a)
        renderer.line(size.x, pos.y, size.x, size.y, clr.r, clr.g, clr.b, clr.a)
        renderer.line(pos.x, size.y, size.x, size.y, clr.r, clr.g, clr.b, clr.a)
    end

    graphics.renderer_rectangle_filled = function(self, pos, size, clr)
        local nWidth = size.x - pos.x
        local nHeight = size.y - pos.y
        if nWidth < 0 then
            if nHeight < 0 then
                renderer.rectangle(size.x, size.y, -nWidth, -nHeight, clr.r, clr.g, clr.b, clr.a)
            else
                renderer.rectangle(size.x, pos.y, -nWidth, nHeight, clr.r, clr.g, clr.b, clr.a)
            end
        else
            if nHeight < 0 then
                renderer.rectangle(pos.x, size.y, nWidth, -nHeight, clr.r, clr.g, clr.b, clr.a)
            else
                renderer.rectangle(pos.x, pos.y, nWidth, nHeight, clr.r, clr.g, clr.b, clr.a)
            end
        end
    end

    graphics.renderer_rectangle_outlined = function(self, pos, size, clr)
        renderer.line(pos.x, pos.y, pos.x, size.y, clr.r, clr.g, clr.b, clr.a)
        renderer.line(pos.x, pos.y, size.x, pos.y, clr.r, clr.g, clr.b, clr.a)
        renderer.line(size.x, pos.y, size.x, size.y, clr.r, clr.g, clr.b, clr.a)
        renderer.line(pos.x, size.y, size.x, size.y, clr.r, clr.g, clr.b, clr.a)
    end

    graphics.renderer_rectangle_filled_gradient = function(self, pos, size, color1, color2, bHorizontal)
        local nWidth = size.x - pos.x
        local nHeight = size.y - pos.y

        if nWidth < 0 then
            if nHeight < 0 then
                renderer.gradient(size.x, size.y, -nWidth, -nHeight, color1.r, color1.g, color1.b, color1.a, color2.r, color2.g, color2.b, color2.a, bHorizontal)
            else
                renderer.gradient(size.x, pos.y, -nWidth, nHeight, color1.r, color1.g, color1.b, color1.a, color2.r, color2.g, color2.b, color2.a, bHorizontal)
            end
        else
            if nHeight < 0 then
                renderer.gradient(pos.x, size.y, nWidth, -nHeight, color2.r, color2.g, color2.b, color2.a, color1.r, color1.g, color1.b, color1.a, bHorizontal)
            else
                renderer.gradient(pos.x, pos.y, nWidth, nHeight, color2.r, color2.g, color2.b, color2.a, color1.r, color1.g, color1.b, color1.a, bHorizontal)
            end
        end
    end

    graphics.draw = function(self, nValues_t, nMinValue, nMaxValue, nInterval, vParams_t, bShowLayout)
        local nZero = nMinValue
        local vColor = vParams_t.clr_1

        nMinValue = 0
        nMaxValue = nMaxValue - nZero

        vParams_t.h = vParams_t.h - vParams_t.thickness
        if bShowLayout then
            self:renderer_rectangle_outlined(
                { x = vParams_t.x, y = vParams_t.y },
                { x = vParams_t.x + vParams_t.w - 1, y = vParams_t.y + vParams_t.h - 1 + vParams_t.thickness },
                { r = vColor[1], g = vColor[2], b = vColor[3], a = vColor[4] }
            )
        end

        if nMinValue == nMaxValue then
            self:renderer_line(
                { x = vParams_t.x, y = vParams_t.y+vParams_t.h },
                { x = vParams_t.x+vParams_t.w, y = vParams_t.y+vParams_t.h },
                { r = vColor[1], g = vColor[2], b = vColor[3], a = vColor[4] }
            )

            return
        end

        local nStepX = vParams_t.w / (nInterval - 1)
        local nDelta = nMaxValue - nMinValue

        for i=1, nInterval - 1 do
            local nPercentage = {
                (nValues_t[i] - nZero) / nDelta,
                (nValues_t[i + 1] - nZero) / nDelta
            }

            local oData = {
                { x = vParams_t.x + nStepX * (i - 1), y = vParams_t.y + vParams_t.h - vParams_t.h * nPercentage[1] },
                { x = vParams_t.x + nStepX * i, y = vParams_t.y + vParams_t.h - vParams_t.h * nPercentage[2] },
            }

            for i=1, vParams_t.thickness do
                self:renderer_line(
                    { x = oData[1].x, y = oData[1].y + i - 1 },
                    { x = oData[2].x, y = oData[2].y + i - 1 },
                    { r = vColor[1], g = vColor[2], b = vColor[3], a = vColor[4] }
                )
            end
        end
    end

    graphics.draw_histogram = function(self, nValues_t, nMinValue, nMaxValue, nInterval, vParams_t, bShowLayout)
        local nZero = nMinValue
        nMinValue = 0
        nMaxValue = nMaxValue - nZero

        if bShowLayout then
            self:renderer_rectangle_outlined(
                { x = vParams_t.x, y = vParams_t.y },
                { x = vParams_t.x + vParams_t.w - 1, y = vParams_t.y + vParams_t.h - 1 },
                { r = 255, g = 255, b = 255, a = 255 }
            )
        end

        local nStepX = vParams_t.w / (nInterval - 1)
        local nDelta = nMaxValue - nMinValue

        for i=1, nInterval - 1 do
            local nPercentage = {
                (nValues_t[i] - nZero) / nDelta,
                (nValues_t[i + 1] - nZero) / nDelta
            }

            local oData = {
                { x = math.floor(vParams_t.x + nStepX * (i - 1)), y = math.floor(vParams_t.y + vParams_t.h - vParams_t.h * nPercentage[1]) },
                { x = math.floor(vParams_t.x + nStepX * i), y = math.floor(vParams_t.y + vParams_t.h) },

                isZero = math.floor(vParams_t.y + vParams_t.h) == math.floor(vParams_t.y + vParams_t.h - vParams_t.h * nPercentage[1])
            }

            if vParams_t.sDrawBar == 'fill' then
                self:renderer_rectangle_filled(
                    { x = oData[1].x, y = oData[1].y },
                    { x = oData[2].x, y = oData[2].y },
                    { r = vParams_t.clr_1[1], g = vParams_t.clr_1[2], b = vParams_t.clr_1[3], a = vParams_t.clr_1[4] }
                )
            elseif vParams_t.sDrawBar == 'gradient_fadeout' then
                self:renderer_rectangle_filled_gradient(
                    { x = oData[1].x, y = oData[1].y },
                    { x = oData[2].x, y = oData[2].y },
                    { r = vParams_t.clr_1[1], g = vParams_t.clr_1[2], b = vParams_t.clr_1[3], a = 0 },
                    { r = vParams_t.clr_1[1], g = vParams_t.clr_1[2], b = vParams_t.clr_1[3], a = vParams_t.clr_1[4] }, false
                )
            elseif vParams_t.sDrawBar == 'gradient_fadein' then
                self:renderer_rectangle_filled_gradient(
                    { x = oData[1].x, y = oData[1].y },
                    { x = oData[2].x, y = oData[2].y },
                    { r = vParams_t.clr_1[1], g = vParams_t.clr_1[2], b = vParams_t.clr_1[3], a = vParams_t.clr_1[4] },
                    { r = vParams_t.clr_1[1], g = vParams_t.clr_1[2], b = vParams_t.clr_1[3], a = 0 }, false
                )
            else

            end

            if vParams_t.bDrawPeeks and not oData.isZero then
                self:renderer_line(
                    { x = oData[1].x, y = oData[1].y },
                    { x = oData[2].x, y = oData[1].y },
                    { r = vParams_t.clr_2[1], g = vParams_t.clr_2[2], b = vParams_t.clr_2[3], a = vParams_t.clr_2[4] }
                )
            end
        end
    end

    return setmetatable(graphics, { __index = { } })
end

local function new_dragging(name, new_pos)
    if name == nil or new_pos == nil then
        return
    end

    if pcall(ui.reference, 'lua', 'b', ('%s:dragging_x'):format(name)) then
        return
    end

    local mt = { }
    local mt_data = {
        dragging = false,

        mouse_pos = vector(0, 0),
        mouse_pos_diff = vector(0, 0),

        reference = (function()
            local vec = vector(
                ui.new_slider('lua', 'b', ('%s:dragging_x'):format(name), -16384, 16384, new_pos.x),
                ui.new_slider('lua', 'b', ('%s:dragging_y'):format(name), -16384, 16384, new_pos.y)
            )

            local visibility = function()
                ui.set_visible(vec.x, false)
                ui.set_visible(vec.y, false)
            end

            ui.set_callback(vec.x, visibility)
            ui.set_callback(vec.y, visibility)

            visibility()

            return vec
        end)()
    }

    mt.intersects = function(self, mouse, pos, size)
        return
            mouse.x >= pos.x and mouse.x <= pos.x+size.x and
            mouse.y >= pos.y and mouse.y <= pos.y+size.y
    end

    mt.get_position = function(self)
        return vector(
            ui.get(self.reference.x),
            ui.get(self.reference.y)
        )
    end

    mt.is_dragging = function(self)
        return self.dragging
    end

    mt.update = function(self, size)
        local new_mouse_pos = vector(ui.mouse_position())
        local menu_pos = vector(ui.menu_position())
        local menu_size = vector(ui.menu_size())

        local holding_key, intersection_check =
            ui.is_menu_open() and client.key_state(1),
            self:intersects(new_mouse_pos, self:get_position(), size) and not
            self:intersects(new_mouse_pos, menu_pos, menu_size)

        self.mouse_pos_diff = -(self.mouse_pos-new_mouse_pos)

        if holding_key and intersection_check then
            self.dragging = true
        elseif not holding_key then
            self.dragging = false
        end

        if self.dragging then
            local screen = vector(client.screen_size())
            local limit, new_pos = size / 2, vector(
                ui.get(self.reference.x) + self.mouse_pos_diff.x,
                ui.get(self.reference.y) + self.mouse_pos_diff.y
            )

            ui.set(self.reference.x, math.max(-limit.x, math.min(screen.x-limit.x, new_pos.x)))
            ui.set(self.reference.y, math.max(-limit.y, math.min(screen.y-limit.y, new_pos.y)))
        end

        self.mouse_pos = new_mouse_pos

        return self:get_position(), self.dragging
    end

    return setmetatable(mt, { __index = mt_data })
end

local function new_keybinds(tween, bindlist)
    local mt = { }
    local mt_data = {
        hotkeys = { },
        hotkeys_active = { },
        hotkeys_update = true,

        tweens = { list = { }, data = { } },
        modes = { 'holding', 'toggled', 'disabled' },

        list = bindlist,
    }

    mt.reference = function(self, ...)
        local ref = { pcall(ui.reference, ...) }

        if ref[1] ~= true then
            return
        end

        local new_rlist = { }

        for i=2, #ref do
            new_rlist[#new_rlist+1] = ref[i]
        end

        return new_rlist
    end

    mt.create_item = function(self, data)
        if data == nil then
            return
        end

        local ref_generated = { }
        local ref = self:reference(unpack(data.reference))

        if ref == nil then
            return
        end

        for i=1, #ref do
            if i <= data.offset then
                ref_generated[i] = ref[i]
            end
        end

        local name =
            data.custom_name and data.custom_name:gsub(' ', '') ~= '' and
            data.custom_name or (data.reference[3] or '?')

        for _, hk in pairs(self.hotkeys) do
            if  hk.reference[1] == data.reference[1] and
                hk.reference[2] == data.reference[2] and
                hk.reference[3] == data.reference[3]
            then
                return
            end
        end

        self.hotkeys[#self.hotkeys+1] = {
            name = name,
            offset = data.offset,
            reference = data.reference,
            collected = ref_generated
        }

        return true
    end

    mt.reset = function(self)
        self.hotkeys_update = true
    end

    mt.handle = function(self)
        local frame = globals.frametime()

        if self.hotkeys_update == true then
            self.hotkeys = { }
            self.hotkeys_active = { }
            self.hotkeys_update = false

            for _, item in pairs(self.list) do
                self:create_item(item)
            end
        end

        for id, hotkey in pairs(self.hotkeys) do
            local is_active = true
            local tween_id = tostring(('id:%d'):format(id))

            local ref = hotkey.collected
            local state = { ui.get(ref[#ref]) }

            if #ref > 1 then
                is_active = ui.get(ref[1])
            end

            if is_active and state[2] ~= 0 and (
                state[2] == 3 and not state[1] or
                state[2] ~= 3 and state[1]
            ) then
                if self.hotkeys_active[id] == nil or self.tweens.data[tween_id] == nil then
                    self.tweens.data[tween_id] = 0
                    self.hotkeys_active[id] = {
                        mode = '',
                        alpha = 0,
                        active = true,
                        name = hotkey.name,

                        data = hotkey,
                        tween = self.tweens.data[tween_id]
                    }
                end

                self.hotkeys_active[id].active = true
                self.hotkeys_active[id].mode = self.modes[state[2]]
            elseif self.hotkeys_active[id] ~= nil then
                self.hotkeys_active[id].active = false

                if  not self.tweens.data[tween_id] or
                    self.tweens.data[tween_id] <= 0.25 then

                    self.hotkeys_active[id] = nil
                    self.tweens.data[tween_id] = nil
                end
            end

            if self.tweens.data[tween_id] ~= nil and self.hotkeys_active[id] ~= nil then
                tween.new(.15, self.tweens.data, {
                    [tween_id] = self.hotkeys_active[id].active and 1 or 0.001
                }):update(frame)

                self.hotkeys_active[id].alpha = self.tweens.data[tween_id]
            end
        end

        local all_inactive = true

        for _, hotkey in pairs(self.hotkeys_active) do
            if hotkey.active == true then
                all_inactive = false
            end
        end

        return
            self.hotkeys_active,
            not all_inactive
    end

    return setmetatable(mt, { __index = mt_data })
end

-- Menu
local rsrc_loc = { 'CONFIG', 'Presets' }
local DPI = ui.reference('MISC', 'Settings', 'DPI Scale')

local watermark = ui.new_checkbox(rsrc_loc[1], rsrc_loc[2], 'Watermark')
local accent_color = ui.new_color_picker(rsrc_loc[1], rsrc_loc[2], 'Watermark accent color', 25, 25, 176, 255)

local text_color_label, text_color =
    ui.new_label(rsrc_loc[1], rsrc_loc[2], 'Watermark text color'),
    ui.new_color_picker(rsrc_loc[1], rsrc_loc[2], 'Watermark text color \n swtm', 56, 121, 247, 255)

local custom_name_reference = ui.new_textbox(rsrc_loc[1], rsrc_loc[2], 'Watermark name')
local antiaim_indicator = ui.new_checkbox(rsrc_loc[1], rsrc_loc[2], 'Anti-aimbot indication')
local keybinds = ui.new_checkbox(rsrc_loc[1], rsrc_loc[2], 'Keybinds')

local resource_manager = ui.new_checkbox(rsrc_loc[1], rsrc_loc[2], 'Resource manager')
local resources = {
    dpi_scale = ui.new_checkbox(rsrc_loc[1], rsrc_loc[2], 'DPI Scale'),

    background_clr_label = ui.new_label(rsrc_loc[1], rsrc_loc[2], 'Background color \n swtm'),
    background_clr = ui.new_color_picker(rsrc_loc[1], rsrc_loc[2], 'bg_color \n swtm', 13, 13, 13, 125),

    roundness = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Watermark roundness \n swtm', 0, 8, 4),
    outline_thickness = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Watermark outline thickness \n swtm', 0, 8, 2),

    outline_position = ui.new_combobox(rsrc_loc[1], rsrc_loc[2], 'Watermark outline position \n swtm', { 'top', 'bottom', 'left', 'right' }),

    shadow_clr_label = ui.new_label(rsrc_loc[1], rsrc_loc[2], 'Shadow color \n swtm'),
    shadow_clr = ui.new_color_picker(rsrc_loc[1], rsrc_loc[2], 'shadow_clr \n swtm', 23, 40, 125, 255),
    shadow_steps = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Shadow steps \n swtm', 1, 32, 6),
    shadow_range = ui.new_slider(rsrc_loc[1], rsrc_loc[2], 'Shadow range \n swtm', 0, 100, 15, true, '', .01),
}

ui.set(resources.dpi_scale, true)

-- General stuff
local graphs = new_graphics()
local db = database.read('sirius') or { }

-- Keybinds
local keybinds_window = new_keybinds(tween, bind_list)
local keybinds_dragging = new_dragging('Keybinds', vector(50, 450))

local pname, pname_prev
local etp_data, etp_data2 =
    { 0, 0, 0, 0, 0 }, { 0, 0 }

local exp_clr = interpolate_colors_range(
    { 255, 255, 255, 0 },
    { 235, 95, 135, 0 }, 10
)

local tween_list = { }
local tween_data = {
    latency = 0,
    wm_text_size_x = 0,
    watermark_alpha = 0,

    antiaim_alpha = 0,
    teleport_alpha = 0,
    shifting_alpha = 0,
    breaking_lc = 0,

    keybinds_alpha = 0,
    keybinds_holding = 1,
    hk_width = 0,

    etp = {
        one = 0,
        two = 0,
        three = 0,
        four = 0,
        five = 0
    }
}

local is_beta = pcall(ui.reference, 'MISC', 'Settings', 'Crash logs')
local is_in_game = vtable_bind('engine.dll', 'VEngineClient014', 26, 'bool(__thiscall*)(void*)')

local get_gc_state = panorama.loadstring('return MyPersonaAPI.IsConnectedToGC()')
local get_player_name = panorama.loadstring('return MyPersonaAPI.GetName()')

local get_ext_count = function(tbl)
    local c = 0

    for k, v in pairs(tbl) do
        c = c+1
    end

    return c
end

local set_font_flags = function(flags)
    local dsc = ui.get(resources.dpi_scale)

    return ('%s%s'):format(
        flags or '',
        dsc and 'd' or ''
    )
end

local get_username = function()
    local edit = ui.get(custom_name_reference)

    if edit ~= pname_prev and pname_prev ~= nil then
        db.custom_name = edit
    elseif edit == '' and db.custom_name ~= nil then
        ui.set(custom_name_reference, db.custom_name)
    end

    pname_prev = edit

    local text = db.custom_name
    if text ~= nil and text:gsub(' ', '') ~= '' then
        pname = text
    else
        pname = nil
    end

    if pname == nil then
        return get_player_name()
    end

    return pname
end

local g_entity_update = function(c)
    if entity.get_local_player() ~= c.id then
        return
    end

    for i=1, #etp_data2 do
        etp_data2[i] = i~=#etp_data2 and
            etp_data2[i+1] or c.data.shifting.ticks
    end

    for i=1, #etp_data do
        etp_data[i] = i~=#etp_data and
            etp_data[i+1] or
            math.max(0, map_linear(
                math.min(c.data.teleport, 8192),
                4096, 8192, 0, 1000
            ))
    end
end

local g_paint_handler = function()
    local frame, dpi_scale =
        globals.frametime(), 1

    local me = entity.get_local_player()
    local command = anti_aim.get_command()

    local hotkeys, last_hk = keybinds_window:handle()
    local can_show_keybinds = ui.get(keybinds) and (
        ui.is_menu_open() or (get_ext_count(hotkeys) > 0 and last_hk)
    )

    if ui.get(resources.dpi_scale) then
        dpi_scale = ui.get(DPI):gsub('%%', '') / 100
    end

    local opts = {
        color = { ui.get(resources.background_clr) },
        outline = {
            position = ui.get(resources.outline_position),
            thickness = ui.get(resources.outline_thickness),
            color = { ui.get(accent_color) }
        },

        shadow = {
            steps = ui.get(resources.shadow_steps),
            range = ui.get(resources.shadow_range)*.01,
            color = { ui.get(resources.shadow_clr) }
        }
    }

    -- Tweening
    local can_break_lc = false

    if entity.is_alive(me) and command then
        local velocity = vector(entity.get_prop(me, 'm_vecVelocity'))

        if math.max(unpack(etp_data2)) > 6 then
            can_break_lc = true
        end

        if velocity:length2d() > 250 or velocity.z > 250 or command.teleport > 4096 then
            can_break_lc = true
        end
    end

    tween_list.latency = tween.new(.15, tween_data, { latency = client.latency()*1000 })
    tween_list.wma = tween.new(.05, tween_data, {
        watermark_alpha = ui.get(watermark) and 1 or 0.001,
        keybinds_alpha = can_show_keybinds and 1 or 0.001,
        keybinds_holding = can_show_keybinds and keybinds_dragging:is_dragging() and 0.6 or 1
    })

    tween_list.ana = tween.new(.1, tween_data, {
        antiaim_alpha = ui.get(antiaim_indicator) and entity.is_alive(me) and 1 or 0.001,
        breaking_lc = etp_data[3] > 0 and etp_data[4] > 0 and etp_data[5] > 0 and 1 or 0.001,
        shifting_alpha = math.max(unpack(etp_data2)) > 6 and 1 or 0.001,
        teleport_alpha = can_break_lc and 1 or 0.001,
    })

    tween_list.etp = tween.new(.1, tween_data.etp, {
        one = etp_data[1], two = etp_data[2],
        three = etp_data[3], four = etp_data[4],
        five = etp_data[5]
    })

    for tname, thandle in pairs(tween_list) do
        if thandle:update(frame) then
            tween_list[tname] = nil
        end
    end

    -- Begin again...
    local screen_size = vector(client.screen_size())
    local offset = vector(10, 0, ui.get(resources.roundness))

    if tween_data.watermark_alpha >= 0.5 then
        local offset_ins = vector(4 * dpi_scale, 4)
        local alpha = map_linear(tween_data.watermark_alpha, 0.5, 1, 0, 1)

        offset.y = offset.y + alpha*10

        local text, text_size = renderer_text_fix(function()
            local player_name = get_username()
            local time = { client.system_time() }
            local suffix = is_beta and ' [beta]' or ''

            -- green: 149, 184, 6, 255 | 95B806FF
            -- blue: 56, 121, 247, 255 | 3879F7FF

            -- neverlose: 02A8F433

            local name = ('game\a%ssense\aFFFFFFFF%s'):format(to_hex(ui.get(text_color)), suffix)
            local str = ('%s  %s  %02d:%02d:%02d'):format(name, player_name, time[1], time[2], time[3])

            if is_in_game() == true then
                local latency_text =
                    tween_data.latency > 1 and ('  %dms'):format(tween_data.latency) or ''

                    str = ('%s  %s%s  %02d:%02d:%02d'):format(name, player_name, latency_text, time[1], time[2], time[3])
            end

            return str
        end, set_font_flags(), alpha*255)

        local text_size_x = math.floor(tween_data.wm_text_size_x)
        local position = vector(
            screen_size.x - offset.x - text_size_x,
            offset.y
        )

        renderer_rounded_rect({
            alpha = alpha * 255,

            position = vector(position.x - offset_ins.x*2, position.y),
            size = vector(text_size_x + offset_ins.x*2, text_size.y + offset_ins.y*2),

            roundness = offset.z,
            color = opts.color,
            outline = opts.outline,
            shadow = opts.shadow
        })

        if text_size_x >= 1 then
            renderer.text(
                position.x + text_size_x - offset_ins.x,
                position.y + offset_ins.y-1,
                255, 255, 255, alpha*255,
                set_font_flags('r'), text_size_x+3, text
            )
        end

        tween_list.watermark_text = tween.new(.15, tween_data, {
            wm_text_size_x = text_size.x
        })

        offset.y = offset.y + alpha*(text_size.y+5)
    end

    if tween_data.antiaim_alpha >= 0.25 then
        local offset_ins = vector(5 * dpi_scale, 2)
        local extra_offset = 0

        local alpha = map_linear(tween_data.antiaim_alpha, 0.25, 1, 0, 1)

        offset.y = offset.y + alpha*10

        -- EXPLOITING INDICATOR
        local text = 'EXPLOITING'
        local text_size = vector(renderer.measure_text(set_font_flags(), text))

        local position = vector(screen_size.x - offset.x - text_size.x, offset.y)

        local rect_alpha = alpha * tween_data.shifting_alpha

        rect_alpha =
            rect_alpha < 0.75 and 0 or
            map_linear(rect_alpha, 0.75, 1, 0, 1)

        renderer_rounded_rect({
            alpha = rect_alpha*255,

            position = vector(position.x - offset_ins.x*2, position.y),
            size = vector(text_size.x + offset_ins.x*2, text_size.y + offset_ins.y*2),

            outline = {
                position = 'bottom',
                style = 2,
                thickness = 1,
                color = { 228, 126, 10, 255 }
            },

            roundness = offset.z,
            color = opts.color,
            shadow = opts.shadow
        })

        local text_clr = exp_clr[math.max(1, math.min(10, command and command.shifting.no_entry or 1))]

        renderer.text(
            position.x - offset_ins.x, position.y + offset_ins.y-1,
            text_clr[1], text_clr[2], text_clr[3], alpha*rect_alpha*255, set_font_flags(), text_size.x+3, text
        )

        extra_offset = extra_offset +
            (text_size.x + offset_ins.x*2 + offset_ins.x) * tween_data.shifting_alpha

        -- GRAPHICS
        local placeholder = string.rep('\x20', 9)
        local text_size = vector(renderer.measure_text(set_font_flags(), placeholder))
        local position = vector(screen_size.x - offset.x - text_size.x - extra_offset, offset.y)

        local rect_alpha = alpha * tween_data.breaking_lc

        rect_alpha =
            rect_alpha < 0.5 and 0 or
            map_linear(rect_alpha, 0.5, 1, 0, 1)

        renderer_rounded_rect({
            alpha = rect_alpha*255,

            position = vector(position.x - offset_ins.x*2, position.y),
            size = vector(text_size.x + offset_ins.x*2, text_size.y + offset_ins.y*2),

            roundness = offset.z,
            color = opts.color,
            shadow = opts.shadow
        })

        local etp_data = {
            tween_data.etp.one,
            tween_data.etp.two,
            tween_data.etp.three,
            tween_data.etp.four,
            tween_data.etp.five,
        }

        graphs:draw(etp_data, 0, 1000, #etp_data, {
            -- x, y, w, h
            x = position.x - offset_ins.x,
            y = position.y + offset_ins.y*2,
            w = text_size.x,
            h = text_size.y - offset_ins.y,

            thickness = 1,
            clr_1 = { 64, 255, 194, 255 * rect_alpha },
        }, false)

        extra_offset = extra_offset +
            (text_size.x + offset_ins.x*2 + offset_ins.x) * tween_data.breaking_lc

        -- FAKELAG INDICATOR
        local text = ('FL: %s%d'):format(
            command and command.choked < 10 and string.rep('\x20', 2) or '',
            command and command.choked or -1
        )

        local text_size = vector(renderer.measure_text(set_font_flags(), text))
        local position = vector(screen_size.x - offset.x - text_size.x - extra_offset, offset.y)

        local color = { 219, 20, 60, 255 }

        if command and command.teleport > 4096 then
            color = { 64, 255, 194, 255 }
        end

        renderer_rounded_rect({
            alpha = alpha * tween_data.teleport_alpha * 255,

            position = vector(position.x - offset_ins.x*2, position.y),
            size = vector(text_size.x + offset_ins.x*2, text_size.y + offset_ins.y*2),

            roundness = offset.z,
            color = opts.color,
            outline = {
                position = 'left',
                style = offset.z == 0 and 2 or 1,
                thickness = offset.z == 0 and 2 or 1,
                color = color
            },

            shadow = opts.shadow
        })

        renderer.text(
            position.x - offset_ins.x, position.y + offset_ins.y-1,
            255, 255, 255, alpha*tween_data.teleport_alpha*255, set_font_flags(), text_size.x+3, text
        )
    end

    if tween_data.keybinds_alpha >= 0.001 then
        local max_width = 40

        for _, hotkey in pairs(hotkeys) do
            if hotkey.active then
                local width = renderer.measure_text(set_font_flags(), hotkey.name) - 10

                if max_width < width then
                    max_width = width
                end
            end
        end

        tween_list.hk_width = tween.new(.05, tween_data, {
            hk_width = max_width
        })

        max_width = math.floor(tween_data.hk_width)

        local alpha = tween_data.keybinds_alpha
        local roundess = offset.z
        local offset_ins = vector(10, 4)

        local text = 'keybinds'
        local text_size = vector(renderer.measure_text(set_font_flags(), text))
        local position = keybinds_dragging:get_position()

        position.x = position.x + offset_ins.x*2

        local size = vector(
            text_size.x + offset_ins.x*2 + max_width+20,
            text_size.y + offset_ins.y*2
        )

        renderer_rounded_rect({
            size = size,
            position = vector(position.x - offset_ins.x*2, position.y),

            alpha = alpha * tween_data.keybinds_holding * 255,

            roundness = roundess,
            color = opts.color,
            outline = {
                position = 'top',
                thickness = opts.outline.thickness,
                color = opts.outline.color
            },

            shadow = opts.shadow
        })

        renderer.text(
            position.x + max_width/2,
            position.y + offset_ins.y-1,
            255, 255, 255, alpha*tween_data.keybinds_holding*255,
            set_font_flags(), text_size.x+3, text
        )

        local offset = 0

        for id, hotkey in pairs(hotkeys) do
            local alpha = alpha*hotkey.alpha
            local text_size, text_alpha =
                vector(renderer.measure_text(set_font_flags(), hotkey.name)), 0

            if alpha >= 0.25 then
                text_alpha = math.min(1, map_linear(alpha, 0.25, 1, 0, 1.2))
            end

            local e_offset = -(6-math.floor(text_size.y/2 * alpha))

            renderer.text(
                position.x - offset_ins.x*2 + roundess - 1,
                position.y + size.y + 4 + offset + e_offset,
                255, 255, 255, text_alpha*tween_data.keybinds_holding*255,
                set_font_flags(), 0, hotkey.name
            )

            renderer.text(
                position.x - offset_ins.x*2 + size.x - roundess + 1,
                position.y + size.y + 4 + offset + e_offset,
                255, 255, 255, text_alpha*tween_data.keybinds_holding*255,
                set_font_flags('r'), 0, ('[%s]'):format(hotkey.mode)
            )

            offset = offset + text_alpha * (text_size.y + text_size.y/2.5)
        end

        keybinds_dragging:update(size)
    end

    -- UI Callback
    local watermark = ui.get(watermark)
    local resource_manager = ui.get(resource_manager)

    ui.set_visible(text_color_label, watermark)
    ui.set_visible(text_color, watermark)
    ui.set_visible(custom_name_reference, watermark)

    for k, v in pairs(resources) do
        ui.set_visible(v, resource_manager)
    end
end

client.set_event_callback('paint_ui', g_paint_handler)
client.set_event_callback('entity_update', g_entity_update)
client.set_event_callback('shutdown', function()
	database.write('sirius', db)
end)
