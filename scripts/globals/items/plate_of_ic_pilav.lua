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
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5584)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 14)
    target:addMod(tpz.mod.FOOD_HP_CAP, 65)
    target:addMod(tpz.mod.STR, 4)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.HPHEAL, 1)
    target:addMod(tpz.mod.FOOD_ATTP, 22)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 65)
    target:addMod(tpz.mod.FOOD_RATTP, 22)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 65)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 14)
    target:delMod(tpz.mod.FOOD_HP_CAP, 65)
    target:delMod(tpz.mod.STR, 4)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.HPHEAL, 1)
    target:delMod(tpz.mod.FOOD_ATTP, 22)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 65)
    target:delMod(tpz.mod.FOOD_RATTP, 22)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 65)
end

return item_object
