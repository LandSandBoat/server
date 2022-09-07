-----------------------------------
-- xi.effect.CORSAIRS_ROLL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.EXP_BONUS, effect:getPower())
    target:addMod(xi.mod.CAPACITY_BONUS, effect:getPower())
    -- TODO: Exemplar Points (Not Implemented)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.EXP_BONUS, effect:getPower())
    target:delMod(xi.mod.CAPACITY_BONUS, effect:getPower())
    -- TODO: Exemplar Points (Not Implemented)
end

return effect_object
