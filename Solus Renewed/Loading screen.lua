local ffi = require 'ffi'
local vector = require 'vector'

local tween = (function()local a={}local b,c,d,e,f,g,h=math.pow,math_sin,math_cos,math.pi,math_sqrt,math_abs,math.asin;local function i(j,k,l,m)return l*j/m+k end;local function n(j,k,l,m)return l*b(j/m,2)+k end;local function o(j,k,l,m)j=j/m;return-l*j*(j-2)+k end;local function p(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,2)+k end;return-l/2*((j-1)*(j-3)-1)+k end;local function q(j,k,l,m)if j<m/2 then return o(j*2,k,l/2,m)end;return n(j*2-m,k+l/2,l/2,m)end;local function r(j,k,l,m)return l*b(j/m,3)+k end;local function s(j,k,l,m)return l*(b(j/m-1,3)+1)+k end;local function t(j,k,l,m)j=j/m*2;if j<1 then return l/2*j*j*j+k end;j=j-2;return l/2*(j*j*j+2)+k end;local function u(j,k,l,m)if j<m/2 then return s(j*2,k,l/2,m)end;return r(j*2-m,k+l/2,l/2,m)end;local function v(j,k,l,m)return l*b(j/m,4)+k end;local function w(j,k,l,m)return-l*(b(j/m-1,4)-1)+k end;local function x(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,4)+k end;return-l/2*(b(j-2,4)-2)+k end;local function y(j,k,l,m)if j<m/2 then return w(j*2,k,l/2,m)end;return v(j*2-m,k+l/2,l/2,m)end;local function z(j,k,l,m)return l*b(j/m,5)+k end;local function A(j,k,l,m)return l*(b(j/m-1,5)+1)+k end;local function B(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,5)+k end;return l/2*(b(j-2,5)+2)+k end;local function C(j,k,l,m)if j<m/2 then return A(j*2,k,l/2,m)end;return z(j*2-m,k+l/2,l/2,m)end;local function D(j,k,l,m)return-l*d(j/m*e/2)+l+k end;local function E(j,k,l,m)return l*c(j/m*e/2)+k end;local function F(j,k,l,m)return-l/2*(d(e*j/m)-1)+k end;local function G(j,k,l,m)if j<m/2 then return E(j*2,k,l/2,m)end;return D(j*2-m,k+l/2,l/2,m)end;local function H(j,k,l,m)if j==0 then return k end;return l*b(2,10*(j/m-1))+k-l*.001 end;local function I(j,k,l,m)if j==m then return k+l end;return l*1.001*(-b(2,-10*j/m)+1)+k end;local function J(j,k,l,m)if j==0 then return k end;if j==m then return k+l end;j=j/m*2;if j<1 then return l/2*b(2,10*(j-1))+k-l*.0005 end;return l/2*1.0005*(-b(2,-10*(j-1))+2)+k end;local function K(j,k,l,m)if j<m/2 then return I(j*2,k,l/2,m)end;return H(j*2-m,k+l/2,l/2,m)end;local function L(j,k,l,m)return-l*(f(1-b(j/m,2))-1)+k end;local function M(j,k,l,m)return l*f(1-b(j/m-1,2))+k end;local function N(j,k,l,m)j=j/m*2;if j<1 then return-l/2*(f(1-j*j)-1)+k end;j=j-2;return l/2*(f(1-j*j)+1)+k end;local function O(j,k,l,m)if j<m/2 then return M(j*2,k,l/2,m)end;return L(j*2-m,k+l/2,l/2,m)end;local function P(Q,R,l,m)Q,R=Q or m*.3,R or 0;if R<g(l)then return Q,l,Q/4 end;return Q,R,Q/(2*e)*h(l/R)end;local function S(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m;if j==1 then return k+l end;Q,R,T=P(Q,R,l,m)j=j-1;return-(R*b(2,10*j)*c((j*m-T)*2*e/Q))+k end;local function U(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m;if j==1 then return k+l end;Q,R,T=P(Q,R,l,m)return R*b(2,-10*j)*c((j*m-T)*2*e/Q)+l+k end;local function V(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m*2;if j==2 then return k+l end;Q,R,T=P(Q,R,l,m)j=j-1;if j<0 then return-.5*R*b(2,10*j)*c((j*m-T)*2*e/Q)+k end;return R*b(2,-10*j)*c((j*m-T)*2*e/Q)*.5+l+k end;local function W(j,k,l,m,R,Q)if j<m/2 then return U(j*2,k,l/2,m,R,Q)end;return S(j*2-m,k+l/2,l/2,m,R,Q)end;local function X(j,k,l,m,T)T=T or 1.70158;j=j/m;return l*j*j*((T+1)*j-T)+k end;local function Y(j,k,l,m,T)T=T or 1.70158;j=j/m-1;return l*(j*j*((T+1)*j+T)+1)+k end;local function Z(j,k,l,m,T)T=(T or 1.70158)*1.525;j=j/m*2;if j<1 then return l/2*j*j*((T+1)*j-T)+k end;j=j-2;return l/2*(j*j*((T+1)*j+T)+2)+k end;local function _(j,k,l,m,T)if j<m/2 then return Y(j*2,k,l/2,m,T)end;return X(j*2-m,k+l/2,l/2,m,T)end;local function a0(j,k,l,m)j=j/m;if j<1/2.75 then return l*7.5625*j*j+k end;if j<2/2.75 then j=j-1.5/2.75;return l*(7.5625*j*j+.75)+k elseif j<2.5/2.75 then j=j-2.25/2.75;return l*(7.5625*j*j+.9375)+k end;j=j-2.625/2.75;return l*(7.5625*j*j+.984375)+k end;local function a1(j,k,l,m)return l-a0(m-j,0,l,m)+k end;local function a2(j,k,l,m)if j<m/2 then return a1(j*2,0,l,m)*.5+k end;return a0(j*2-m,0,l,m)*.5+l*.5+k end;local function a3(j,k,l,m)if j<m/2 then return a0(j*2,k,l/2,m)end;return a1(j*2-m,k+l/2,l/2,m)end;a.easing={linear=i,inQuad=n,outQuad=o,inOutQuad=p,outInQuad=q,inCubic=r,outCubic=s,inOutCubic=t,outInCubic=u,inQuart=v,outQuart=w,inOutQuart=x,outInQuart=y,inQuint=z,outQuint=A,inOutQuint=B,outInQuint=C,inSine=D,outSine=E,inOutSine=F,outInSine=G,inExpo=H,outExpo=I,inOutExpo=J,outInExpo=K,inCirc=L,outCirc=M,inOutCirc=N,outInCirc=O,inElastic=S,outElastic=U,inOutElastic=V,outInElastic=W,inBack=X,outBack=Y,inOutBack=Z,outInBack=_,inBounce=a1,outBounce=a0,inOutBounce=a2,outInBounce=a3}local function a4(a5,a6,a7)a7=a7 or a6;local a8=getmetatable(a6)if a8 and getmetatable(a5)==nil then setmetatable(a5,a8)end;for a9,aa in pairs(a6)do if type(aa)=='table'then a5[a9]=a4({},aa,a7[a9])else a5[a9]=a7[a9]end end;return a5 end;local function ab(ac,ad,ae)ae=ae or{}local af,ag;for a9,ah in pairs(ad)do af,ag=type(ah),a4({},ae)table.insert(ag,tostring(a9))if af=='number'then assert(type(ac[a9])=='number','Parameter \''..table.concat(ag,'/')..'\' is missing from subject or isn\'t a number')elseif af=='table'then ab(ac[a9],ah,ag)else assert(af=='number','Parameter \''..table.concat(ag,'/')..'\' must be a number or table of numbers')end end end;local function ai(aj,ac,ad,ak)assert(type(aj)=='number'and aj>0,'duration must be a positive number. Was '..tostring(aj))local al=type(ac)assert(al=='table'or al=='userdata','subject must be a table or userdata. Was '..tostring(ac))assert(type(ad)=='table','target must be a table. Was '..tostring(ad))assert(type(ak)=='function','easing must be a function. Was '..tostring(ak))ab(ac,ad)end;local function am(ak)ak=ak or'linear'if type(ak)=='string'then local an=ak;ak=a.easing[an]if type(ak)~='function'then error('The easing function name \''..an..'\' is invalid')end end;return ak end;local function ao(ac,ad,ap,aq,aj,ak)local j,k,l,m;for a9,aa in pairs(ad)do if type(aa)=='table'then ao(ac[a9],aa,ap[a9],aq,aj,ak)else j,k,l,m=aq,ap[a9],aa-ap[a9],aj;ac[a9]=ak(j,k,l,m)end end end;local ar={}local as={__index=ar}function ar:set(aq)assert(type(aq)=='number','clock must be a positive number or 0')self.initial=self.initial or a4({},self.target,self.subject)self.clock=aq;if self.clock<=0 then self.clock=0;a4(self.subject,self.initial)elseif self.clock>=self.duration then self.clock=self.duration;a4(self.subject,self.target)else ao(self.subject,self.target,self.initial,self.clock,self.duration,self.easing)end;return self.clock>=self.duration end;function ar:reset()return self:set(0)end;function ar:update(at)assert(type(at)=='number','dt must be a number')return self:set(self.clock+at)end;function a.new(aj,ac,ad,ak)ak=am(ak)ai(aj,ac,ad,ak)return setmetatable({duration=aj,subject=ac,target=ad,easing=ak,clock=0},as)end;return a end)()
local cron = (function()local b={}local function c(d)local e=type(d)if e=='function'then return true end;if e=='table'then local f=getmetatable(d)return type(f)=='table'and type(f.__call)=='function'end;return false end;local function g(h,i)if type(i)~="number"or i<0 then error(h.." must be a positive number")end end;local j={}local k={__index=j}local function l(m,d,n,...)g('time',m)assert(c(d),"callback must be a function")return setmetatable({time=m,callback=d,args={...},running=0,update=n},k)end;local function o(self,p)g('dt',p)if self.running>=self.time then return true end;self.running=self.running+p;if self.running>=self.time then self.callback(unpack(self.args))return true end;return false end;local function q(self,p)g('dt',p)self.running=self.running+p;while self.running>=self.time do self.callback(unpack(self.args))self.running=self.running-self.time end;return false end;function j:reset(r)r=r or 0;g('running',r)self.running=r end;function b.after(m,d,...)return l(m,d,o,...)end;function b.every(m,d,...)return l(m,d,q,...)end;return b end)()
local spinners = (function(tween,cron)local a;do local b;local c;local d={AnimatePhaseIn=function(self)if not(self.tConfig or self.tTweens or self.tCrons or self.tProperties)then return end;self.tProperties.nFillProgress=self.tConfig.nFillProgressReset;self.tProperties.nRotationOffset=self.tConfig.nOffsetDegreesReset;self.tTweens[1]=tween.new(self.tConfig.nTimePhaseIn,self.tProperties,{nFillProgress=self.tConfig.nFillProgressPhaseIn},"inOutQuad")self.tTweens[2]=tween.new(self.tConfig.nTimePhaseIn,self.tProperties,{nRotationOffset=self.tConfig.nOffsetDegreesPhaseIn},"inOutQuad")self.tCrons[1]=cron.after(self.tConfig.nTimePhaseIn,(function()local e=self;local f=e.AnimatePhaseOut;return function(...)return f(e,...)end end)())end,AnimatePhaseOut=function(self)if not(self.tConfig or self.tTweens or self.tCrons or self.tProperties)then return end;self.tTweens[1]=tween.new(self.tConfig.nTimePhaseOut,self.tProperties,{nFillProgress=self.tConfig.nFillProgressPhaseOut},"inOutQuad")self.tTweens[2]=tween.new(self.tConfig.nTimePhaseOut,self.tProperties,{nRotationOffset=self.tConfig.nOffsetDegreesPhaseOut},"inOutQuad")self.tCrons[2]=cron.after(self.tConfig.nTimePhaseOut,(function()local e=self;local f=e.AnimatePhaseIn;return function(...)return f(e,...)end end)())end,OnEvent=function(self)if not(self.tConfig or self.tTweens or self.tCrons or self.tProperties)then return end;if self.tTweens[1]and self.tTweens[1]:update(self.tProperties.tTimeRef.nFrameTime)then self.tTweens[1]=nil end;if self.tTweens[2]and self.tTweens[2]:update(self.tProperties.tTimeRef.nFrameTime)then self.tTweens[2]=nil end;if self.tCrons[1]and self.tCrons[1]:update(self.tProperties.tTimeRef.nFrameTime)then self.tCrons[1]=nil end;if self.tCrons[2]and self.tCrons[2]:update(self.tProperties.tTimeRef.nFrameTime)then self.tCrons[2]=nil end;self.tProperties.nGlobalRotationOffset=self.tProperties.nRotationOffset+self.tProperties.tTimeRef.nRealTime*self.tConfig.nRPS end,Destroy=function(self)self.tProperties.fnEventCallbackUnsetter((function()local e=self;local f=e.OnEvent;return function(...)return f(e,...)end end)())self.tConfig=nil;self.tTweens=nil;self.tCrons=nil;self.tProperties=nil end}d.__index=d;b=setmetatable({__init=function(self,g,h,i,j)self.tConfig=j or c;self.tTweens={false,false}self.tCrons={false,false}self.tProperties={nFillProgress=false,nRotationOffset=false,nGlobalRotationOffset=false,tTimeRef=g,fnEventCallbackUnsetter=i}h((function()local e=self;local f=e.OnEvent;return function(...)return f(e,...)end end)())self:AnimatePhaseIn()return self end,__base=d,__name="CircleSpinner"},{__index=d,__call=function(k,...)local l=setmetatable({},d)k.__init(l,...)return l end})d.__class=b;local self=b;c={nTimePhaseIn=.75,nTimePhaseOut=.75,nRPS=180,nFillProgressPhaseIn=.75,nFillProgressPhaseOut=.075,nFillProgressReset=.075,nOffsetDegreesPhaseIn=90,nOffsetDegreesPhaseOut=360,nOffsetDegreesReset=0}a=b end;local m;do local b;local c,n;local d={AnimatePhaseIn=function(self)if not(self.tConfig or self.tTweens or self.tCrons or self.tProperties)then return end;self.tProperties.nProgressPhaseInLeft=self.tConfig.nProgressPhaseInLeftReset;self.tProperties.nProgressPhaseInRight=self.tConfig.nProgressPhaseInRightReset;self.tTweens[1]=tween.new(self.tConfig.nTimePhaseIn,self.tProperties,{nProgressPhaseInLeft=self.tConfig.nProgressPhaseInLeft},self.tProperties.fnCubicBezierPhaseIn)self.tTweens[2]=tween.new(self.tConfig.nTimePhaseIn,self.tProperties,{nProgressPhaseInRight=self.tConfig.nProgressPhaseInRight},self.tProperties.fnCubicBezierPhaseIn)self.tCrons[1]=cron.after(self.tConfig.nTimePhaseInOutDelay,(function()local e=self;local f=e.AnimatePhaseOut;return function(...)return f(e,...)end end)())end,AnimatePhaseOut=function(self)if not(self.tConfig or self.tTweens or self.tCrons or self.tProperties)then return end;self.tProperties.nProgressPhaseOutLeft=self.tConfig.nProgressPhaseOutLeftReset;self.tProperties.nProgressPhaseOutRight=self.tConfig.nProgressPhaseOutRightReset;self.tTweens[3]=tween.new(self.tConfig.nTimePhaseOut,self.tProperties,{nProgressPhaseOutLeft=self.tConfig.nProgressPhaseOutLeft},self.tProperties.fnCubicBezierPhaseOut)self.tTweens[4]=tween.new(self.tConfig.nTimePhaseOut,self.tProperties,{nProgressPhaseOutRight=self.tConfig.nProgressPhaseOutRight},self.tProperties.fnCubicBezierPhaseOut)self.tCrons[2]=cron.after(self.tConfig.nTimePhaseOutInDelay,(function()local e=self;local f=e.AnimatePhaseIn;return function(...)return f(e,...)end end)())end,OnEvent=function(self)if not(self.tConfig or self.tTweens or self.tCrons or self.tProperties)then return end;if self.tTweens[1]and self.tTweens[1]:update(self.tProperties.tTimeRef.nFrameTime)then self.tTweens[1]=nil end;if self.tTweens[2]and self.tTweens[2]:update(self.tProperties.tTimeRef.nFrameTime)then self.tTweens[2]=nil end;if self.tTweens[3]and self.tTweens[3]:update(self.tProperties.tTimeRef.nFrameTime)then self.tTweens[3]=nil end;if self.tTweens[4]and self.tTweens[4]:update(self.tProperties.tTimeRef.nFrameTime)then self.tTweens[4]=nil end;if self.tCrons[1]and self.tCrons[1]:update(self.tProperties.tTimeRef.nFrameTime)then self.tCrons[1]=nil end;if self.tCrons[2]and self.tCrons[2]:update(self.tProperties.tTimeRef.nFrameTime)then self.tCrons[2]=nil end end,Destroy=function(self)self.tProperties.fnEventCallbackUnsetter((function()local e=self;local f=e.OnEvent;return function(...)return f(e,...)end end)())self.tConfig=nil;self.tTweens=nil;self.tCrons=nil;self.tProperties=nil end}d.__index=d;b=setmetatable({__init=function(self,g,h,i,j)self.tConfig=j or c;self.tTweens={false,false}self.tCrons={false,false}self.tProperties={nProgressPhaseInLeft=false,nProgressPhaseInRight=false,nProgressPhaseOutLeft=false,nProgressPhaseOutRight=false,tTimeRef=g,fnEventCallbackUnsetter=i,fnCubicBezierPhaseIn=n(self.tConfig.tCubicBezierPhaseIn),fnCubicBezierPhaseOut=n(self.tConfig.tCubicBezierPhaseOut)}h((function()local e=self;local f=e.OnEvent;return function(...)return f(e,...)end end)())self:AnimatePhaseIn()return self end,__base=d,__name="RectangleSpinner"},{__index=d,__call=function(k,...)local l=setmetatable({},d)k.__init(l,...)return l end})d.__class=b;local self=b;c={tCubicBezierPhaseIn={0,0,0.65,0.81,0.73,0.4,1,1},tCubicBezierPhaseOut={0,0,0.16,0.84,0.44,1,1,1},nProgressPhaseInLeft=1,nProgressPhaseInLeftReset=-.35,nProgressPhaseInRight=-.9,nProgressPhaseInRightReset=1,nProgressPhaseOutLeft=1.07,nProgressPhaseOutLeftReset=-2,nProgressPhaseOutRight=-.08,nProgressPhaseOutRightReset=1,nTimePhaseIn=1.26,nTimePhaseInOutDelay=0.69,nTimePhaseOut=1.26,nTimePhaseOutInDelay=1.26}n=function(o)return function(p,q,r,s)p=p/s;return r*((1-p)*(1-p)*(1-p)*o[1]+3*(1-p)*(1-p)*p*o[3]+3*(1-p)*p*p*o[5]+p*p*p*o[7])+q end end;m=b end;return{CircleSpinner=a,RectangleSpinner=m}end)(tween,cron)
local get_color = function(b,c,d)local e={{255,0,0},{237,27,3},{235,63,6},{229,104,8},{228,126,10},{220,169,16},{213,201,19},{176,205,10},{124,195,13}}local f=function(g,c,h)local g=g>c and c or g;local i=c/g;if not h then h=c end;local d=h/i;d=d>=0 and math.floor(d+.5)or math.ceil(d-.5)return d end;d=f(b,c,#e)return e[d<=1 and 1 or d][1],e[d<=1 and 1 or d][2],e[d<=1 and 1 or d][3],d end

local create_blur_instance = function()
    local panorama_code = [[
        return {
            new: function(_g) {
                let context_panel = $.GetContextPanel();
                let panel = $.CreatePanel('Panel', context_panel, 'Leaf');
                let co_r = function(res, or) { return (res/or)*100 }
                let gauss = _g

                if(!panel)
                    return;

                let layout = `
                    <root>
                        <styles>
                            <include src='file://{resources}/styles/csgostyles.css' />
                            <include src='file://{resources}/styles/hud/hud.css' />
                        </styles>

                        <Panel class='full-width full-height' hittest='false' hittestchildren='false'>
                            <CSGOBlurTarget id='HudBlurG' style='width:100%;height:100%;-s2-mix-blend-mode:normal;blur:fastgaussian(${gauss},${gauss},${gauss});'>
                                    <CSGOBackbufferImagePanel class='full-width full-height' />
                            </CSGOBlurTarget>
                        </Panel>
                    </root>
                `;

                if(!panel.BLoadLayoutFromString(layout, false, false))
                    return;

                panel.visible = false;
                panel.style.clip = `rect(0%, 0%, 0%, 0%)`;

                return {
                    set_factor: function(value) {
                        if (panel == null)
                            return;
                        gauss = value
                    },
                    set_visible: function(value) {
                        if (panel == null)
                            return;

                        value = value === false ? 0 : value;
                        value = value === true ? 1 : value;

                        let res = (gauss - 1) * value + 1;

                        panel.visible = value > .000;
                        panel.GetChild(0).style.blur = `fastgaussian(${res},${res},${res})`;
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
                return blur.new(1)
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
            pos.x == nil or size.x == nil
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
        for id, blur_instance in pairs(eblur.callbacks) do
            pcall(function()
                blur_instance.set_position(0, 0, 0, 0)
                blur_instance.set_visible(false)
                blur_instance.release()
            end)
        end
    end

    local on_render = function()
        for _, blur_instance in pairs(eblur.callbacks) do
            if not eblur.is_active then
                blur_instance.set_visible(false)
            else
                blur_instance.set_factor(eblur.factor)
                blur_instance.set_visible(eblur.visibility)

                blur_instance.set_position(
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

-- FFI
local LevelLoadingProgress_e = {
	[-2] = "INVALID",
	[-1] = "DEFAULT",

	[0] = "Successfully connected",
	"Map change in progress",
	"Creating server",
	"Loading world model",
	"Verifying map crc",
	"Verifying client.dll crc",
	"Creating network tables",
	"World precache #1",
	"World precache #2",
	"Initializing world",
	"Final precaching",
	"Server activation in progress",
	"Begin connect",
	"Signon challenge",
	"Signon connect",
	"Signon connected",
	"Processing server info #1",
	"Processing server info #2",
	"Signon new",
	"Sending client info",
	"Sending signon data",
	"Signon spawn",
	"Creating entities",
	"Connected to the server",
	"Precaching lighting",
	"Client ready",
	"HIGHESTITEM"
}

local vgui_t = ffi.typeof([[
	struct {
		char pad_0000[92];
		int loading_progress;
		char pad_0060[14968];
	}
]])

local vgui = ffi.cast(ffi.typeof("$*", vgui_t), client.create_interface("engine.dll", "VEngineVGui001"))[0]

-- DEP
local function clamp(nValue, nMin, nMax)
    return math.max(nMin, math.min(nMax, nValue))
end

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

-- OTHER
local tween_data = {
    global_alpha = 0,
    loading_prg = 0
}

local tTimeRef = { nFrameTime = 0, nRealTime = 0 }
local fnPaintUiCallbackSetter = function(fnCallback) return client.set_event_callback("paint_ui", fnCallback) end
local fnPaintUiCallbackUnsetter = function(fnCallback) return client.unset_event_callback("paint_ui", fnCallback) end

-- etc
local menu_blur = create_blur_instance()
local progress_bar = spinners.RectangleSpinner(tTimeRef, fnPaintUiCallbackSetter, fnPaintUiCallbackUnsetter)

client.set_event_callback('paint_ui', function()
    tween.new(
        .075, tween_data, {
            global_alpha = math.floor(tween_data.loading_prg) > 0 and 1 or 0.001,
            loading_prg = vgui.loading_progress
        }
    ):update(globals.absoluteframetime())

    tTimeRef.nFrameTime = globals.frametime()
    tTimeRef.nRealTime = globals.realtime()

    if tween_data.global_alpha > 0.01 then
        local start = vector(0, 0)
        local offset = vector(2, 2)

        local screen_size = vector(client.screen_size())
        local panel_alpha = tween_data.global_alpha

        -- BLUR / Background
        if panel_alpha > 0.25 then
            menu_blur:renderer_rect(
                start, screen_size, 3.5,
                map_linear(panel_alpha, 0.25, 1, 0.4, 1)
            )
        end

        renderer.rectangle(
            start.x, start.y, screen_size.x, screen_size.y,
            0, 0, 0, panel_alpha*150
        )

        -- PANEL
        local ins_offset = vector(145, 52)
        local panel_pos = vector(
            screen_size.x/2 - ins_offset.x/2,
            screen_size.y/2 - ins_offset.y/2
        )

        renderer_rounded_rect({
            alpha = panel_alpha * 255,
            position = panel_pos, size = ins_offset,
            roundness = 4,  color = { 7, 7, 7, 125 },
            outline = { position = 'top', thickness = 2, color = { 25, 25, 176, 255 } },
            shadow = { steps = 6, range = 15*.01,  color = { 23, 40, 125, 255 } }
        })

        renderer.text(
            panel_pos.x + 3, panel_pos.y + 4 + offset.y,
            255, 255, 255, 255 * panel_alpha, '-', nil, ('SOLUS UI %s [CONNECTING]'):format(string.rep('\x20', 2))
        )

        offset.y = offset.y + 18

        local lprg = map_linear(math.max(14, vgui.loading_progress), 14, 25, 0, 1)

        local r, g, b = get_color(lprg * 10, 10)
        local ar, ag, ab =
            r - (r/100 * 50),
            g - (g/100 * 50),
            b - (b/100 * 50)

        local text = LevelLoadingProgress_e[vgui.loading_progress]
        local text_size = vector(renderer.measure_text('', text))

        local gradient_seg = text_size.y / 2
        renderer.gradient(panel_pos.x + offset.x + 3, panel_pos.y + offset.y, 2, gradient_seg, ar, ag, ab, 0, r, g, b, panel_alpha*255, false)
        renderer.gradient(panel_pos.x + offset.x + 3, panel_pos.y + offset.y + gradient_seg, 2, gradient_seg, r, g, b, panel_alpha*255, ar, ag, ab, 0, false)

        renderer.text(panel_pos.x + offset.x + 9, panel_pos.y + offset.y, 255, 255, 255, panel_alpha*255, '', nil, text)

        offset.y = offset.y + 16

        local text = 'LD: '
        local text_size = vector(renderer.measure_text('-', text))

        renderer.text(panel_pos.x + offset.x + 9, panel_pos.y + offset.y, 255, 255, 255, panel_alpha*255, '-', nil, text)

        local pos = vector(
            panel_pos.x + offset.x + 9 + text_size.x + 4,
            panel_pos.y + offset.y + 4
        )

        local sz = vector(ins_offset.x - offset.x - 9 - text_size.x - 16, 4)

        renderer.rectangle(pos.x - 1, pos.y - 1, sz.x + 1, sz.y + 2, 0, 0, 0, panel_alpha*220)

        if not progress_bar or not (vgui.loading_progress == 14 or vgui.loading_progress == 13) then
            renderer.rectangle(pos.x, pos.y, sz.x * lprg, sz.y, 127, 153, 255, panel_alpha*255)
        else
            if progress_bar.tProperties.nProgressPhaseInLeft and progress_bar.tProperties.nProgressPhaseInRight then
                local nX1, nY1 = pos.x + clamp(progress_bar.tProperties.nProgressPhaseInLeft, 0, 1) * sz.x, pos.y
                local nX2, nY2 = pos.x + (1 - clamp(progress_bar.tProperties.nProgressPhaseInRight, 0, 1)) * sz.x, pos.y

                renderer.rectangle(nX1, pos.y, nX2 - nX1, sz.y, 127, 153, 255, panel_alpha*255)
            end

            if progress_bar.tProperties.nProgressPhaseOutLeft and progress_bar.tProperties.nProgressPhaseOutRight then
                local nX1, nY1 = pos.x + clamp(progress_bar.tProperties.nProgressPhaseOutLeft, 0, 1) * sz.x, pos.y
                local nX2, nY2 = pos.x + (1 - clamp(progress_bar.tProperties.nProgressPhaseOutRight, 0, 1)) * sz.x, pos.y

                renderer.rectangle(nX1, pos.y, nX2 - nX1, sz.y, 127, 153, 255, panel_alpha*255)
            end
        end
    end
end)