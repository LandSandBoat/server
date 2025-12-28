-----------------------------------
-- ID: 5190
-- Item: dish_of_spaghetti_carbonara
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 14
-- Health Cap 175
-- Magic 10
-- Strength 4
-- Vitality 2
-- Intelligence -3
-- Attack % 17
-- Attack Cap 65
-- Store TP 6
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
    effect:addMod(xi.mod.FOOD_HPP, 14)
    effect:addMod(xi.mod.FOOD_HP_CAP, 175)
    effect:addMod(xi.mod.FOOD_MP, 10)
    effect:addMod(xi.mod.STR, 4)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.FOOD_ATTP, 17)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 65)
    effect:addMod(xi.mod.STORETP, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
