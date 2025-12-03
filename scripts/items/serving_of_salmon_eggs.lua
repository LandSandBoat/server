-----------------------------------
-- ID: 5217
-- Item: serving_of_salmon_eggs
-- Food Effect: 5Min, All Races
-----------------------------------
-- Health 6
-- Magic 6
-- Dexterity 2
-- Mind -3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 6)
    effect:addMod(xi.mod.FOOD_MP, 6)
    effect:addMod(xi.mod.DEX, 2)
    effect:addMod(xi.mod.MND, -3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
