-----------------------------------
-- ID: 4490
-- Item: Pickled Herring
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 3
-- Mind -3
-- Attack % 12 (cap 70)
-- Ranged ATT % 12 (cap 70)
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
    effect:addMod(xi.mod.DEX, 3)
    effect:addMod(xi.mod.MND, -3)
    effect:addMod(xi.mod.FOOD_ATTP, 12)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 70)
    effect:addMod(xi.mod.FOOD_RATTP, 12)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 70)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
