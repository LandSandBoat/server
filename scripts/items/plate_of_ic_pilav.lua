-----------------------------------
-- ID: 5584
-- Item: plate_of_ic_pilav
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health % 14
-- Health Cap 65
-- Strength 4
-- Vitality -1
-- Intelligence -1
-- Health Regen While Healing 1
-- Attack % 22
-- Attack Cap 65
-- Ranged ATT % 22
-- Ranged ATT Cap 65
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
    effect:addMod(xi.mod.FOOD_HPP, 14)
    effect:addMod(xi.mod.FOOD_HP_CAP, 65)
    effect:addMod(xi.mod.STR, 4)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.INT, -1)
    effect:addMod(xi.mod.HPHEAL, 1)
    effect:addMod(xi.mod.FOOD_ATTP, 22)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 65)
    effect:addMod(xi.mod.FOOD_RATTP, 22)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 65)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
