-----------------------------------
-- ID: 4584
-- Item: serving_of_flounder_meuniere
-- Food Effect: 180Min, All Races
-----------------------------------
-- Dexterity 6
-- Mind -1
-- Ranged ACC 15
-- Ranged ATT % 14
-- Ranged ATT Cap 25
-- Enmity -3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, 6)
    effect:addMod(xi.mod.MND, -1)
    effect:addMod(xi.mod.RACC, 15)
    effect:addMod(xi.mod.FOOD_RATTP, 14)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 25)
    effect:addMod(xi.mod.ENMITY, -3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
