-----------------------------------
-- tpz.effect.BLINK
-- No need for addMod since blinks never stack.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:setMod(tpz.mod.BLINK, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setMod(tpz.mod.BLINK, 0)
end

return effecttbl
