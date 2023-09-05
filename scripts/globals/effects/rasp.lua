-----------------------------------
-- xi.effect.RASP
require("scripts/globals/magic")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGEN_DOWN, effect:getPower())
    target:addMod(xi.mod.DEX, -xi.magic.getElementalDebuffStatDownFromDOT(effect:getPower()))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGEN_DOWN, effect:getPower())
    target:delMod(xi.mod.DEX, -xi.magic.getElementalDebuffStatDownFromDOT(effect:getPower()))
end

return effectObject
