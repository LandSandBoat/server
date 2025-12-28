-----------------------------------
-- ID: 4589
-- Item: Bowl of Wild Stew
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength 4
-- Agility 1
-- Vitality 2
-- Intelligence -2
-- Attack % 25
-- Attack Cap 50
-- Ranged ATT % 25
-- Ranged ATT Cap 50
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 4)
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.FOOD_ATTP, 25)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 50)
    effect:addMod(xi.mod.FOOD_RATTP, 25)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 50)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
