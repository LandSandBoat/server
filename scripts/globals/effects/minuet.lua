-----------------------------------
-- tpz.effect.MINUET
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ATT, effect:getPower())
    target:addMod(tpz.mod.RATT, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATT, effect:getPower())
    target:delMod(tpz.mod.RATT, effect:getPower())
end

return effect_object
