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
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5585)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 14)
    target:addMod(xi.mod.FOOD_HP_CAP, 70)
    target:addMod(xi.mod.STR, 5)
    target:addMod(xi.mod.VIT, -2)
    target:addMod(xi.mod.INT, -2)
    target:addMod(xi.mod.HPHEAL, 1)
    target:addMod(xi.mod.FOOD_ATTP, 22)
    target:addMod(xi.mod.FOOD_ATT_CAP, 70)
    target:addMod(xi.mod.FOOD_RATTP, 22)
    target:addMod(xi.mod.FOOD_RATT_CAP, 70)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 14)
    target:delMod(xi.mod.FOOD_HP_CAP, 70)
    target:delMod(xi.mod.STR, 5)
    target:delMod(xi.mod.VIT, -2)
    target:delMod(xi.mod.INT, -2)
    target:delMod(xi.mod.HPHEAL, 1)
    target:delMod(xi.mod.FOOD_ATTP, 22)
    target:delMod(xi.mod.FOOD_ATT_CAP, 70)
    target:delMod(xi.mod.FOOD_RATTP, 22)
    target:delMod(xi.mod.FOOD_RATT_CAP, 70)
end

return itemObject
