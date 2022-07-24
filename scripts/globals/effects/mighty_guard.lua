-----------------------------------
-- xi.effect.MIGHTY_GUARD
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGEN, 30)
    target:addMod(xi.mod.HASTE_MAGIC, 15)
    target:addMod(xi.mod.DEFENSE_BOOST, 25)
    target:addMod(xi.mod.MAGIC_DEF_BOOST, 15)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.MIGHTY_STRIKES_EFFECT)
    target:delMod(xi.mod.REGEN, 30)
    target:delMod(xi.mod.HASTE_MAGIC, 15)
    target:delMod(xi.mod.DEFENSE_BOOST, 25)
    target:delMod(xi.mod.MAGIC_DEF_BOOST, 15)
end

return effect_object
