-----------------------------------
-- xi.effect.SHOCK
require("scripts/globals/magic")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGEN_DOWN, effect:getPower())
    target:addMod(xi.mod.MND, -xi.magic.getElementalDebuffStatDownFromDOT(effect:getPower()))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGEN_DOWN, effect:getPower())
    target:delMod(xi.mod.MND, -xi.magic.getElementalDebuffStatDownFromDOT(effect:getPower()))
end

return effectObject
