-----------------------------------
-- ID: 5585
-- Item: plate_of_ic_pilav_+1
-- Food Effect: 240Min, All Races
-----------------------------------
-- Health % 14
-- Health Cap 70
-- Strength 5
-- Vitality -2
-- Intelligence -2
-- Health Regen While Healing 1
-- Attack % 22
-- Attack Cap 70
-- Ranged ATT % 22
-- Ranged ATT Cap 70
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
    effect:addMod(xi.mod.FOOD_HPP, 14)
    effect:addMod(xi.mod.FOOD_HP_CAP, 70)
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.VIT, -2)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.HPHEAL, 1)
    effect:addMod(xi.mod.FOOD_ATTP, 22)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 70)
    effect:addMod(xi.mod.FOOD_RATTP, 22)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 70)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
