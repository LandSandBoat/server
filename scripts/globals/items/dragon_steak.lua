-----------------------------------
-- ID: 4350
-- Item: dragon_steak
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 25
-- Strength 7
-- Intelligence -3
-- Health Regen While Healing 2
-- MP recovered while healing +2
-- Attack % 20
-- Attack Cap 150
-- Ranged ATT % 20
-- Ranged ATT Cap 150
-- Demon Killer 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4350)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 25)
    target:addMod(tpz.mod.STR, 7)
    target:addMod(tpz.mod.INT, -3)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 2)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 150)
    target:addMod(tpz.mod.FOOD_RATTP, 20)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 150)
    target:addMod(tpz.mod.DEMON_KILLER, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 25)
    target:delMod(tpz.mod.STR, 7)
    target:delMod(tpz.mod.INT, -3)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 2)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 150)
    target:delMod(tpz.mod.FOOD_RATTP, 20)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 150)
    target:delMod(tpz.mod.DEMON_KILLER, 5)
end

return item_object
