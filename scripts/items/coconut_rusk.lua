-----------------------------------
-- ID: 5784
-- Item: coconut_rusk
-- Food Effect: 30 Min, All Races
-----------------------------------
-- High-quality success rate +3
-- Synthesis failure rate -6%
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.SYNTH_HQ_RATE, 3)
    effect:addMod(xi.mod.SYNTH_MATERIAL_LOSS, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
