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
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5584)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 14)
    target:addMod(xi.mod.FOOD_HP_CAP, 65)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.HPHEAL, 1)
    target:addMod(xi.mod.FOOD_ATTP, 22)
    target:addMod(xi.mod.FOOD_ATT_CAP, 65)
    target:addMod(xi.mod.FOOD_RATTP, 22)
    target:addMod(xi.mod.FOOD_RATT_CAP, 65)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 14)
    target:delMod(xi.mod.FOOD_HP_CAP, 65)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.HPHEAL, 1)
    target:delMod(xi.mod.FOOD_ATTP, 22)
    target:delMod(xi.mod.FOOD_ATT_CAP, 65)
    target:delMod(xi.mod.FOOD_RATTP, 22)
    target:delMod(xi.mod.FOOD_RATT_CAP, 65)
end

return itemObject
