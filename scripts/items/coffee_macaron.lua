-----------------------------------
-- ID: 5780
-- Item: coffee_macaron
-- Food Effect: 30Min, All Races
-----------------------------------
-- Increases rate of synthesis success +5%
-- Increases synthesis skill gain rate +5%
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
    effect:addMod(xi.mod.SYNTH_SUCCESS_RATE, 5)
    effect:addMod(xi.mod.SYNTH_SKILL_GAIN, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
