-----------------------------------
-- tpz.effect.BARTHUNDER
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.THUNDERRES, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.THUNDERRES, effect:getPower())
end

return effect_object
