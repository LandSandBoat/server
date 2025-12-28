-----------------------------------
-- ID: 5218
-- Item: serving_of_salmon_roe
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 8
-- Magic 8
-- Dexterity 2
-- Mind -1
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
    effect:addMod(xi.mod.FOOD_HP, 8)
    effect:addMod(xi.mod.FOOD_MP, 8)
    effect:addMod(xi.mod.DEX, 2)
    effect:addMod(xi.mod.MND, -1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
