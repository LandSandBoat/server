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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4350)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 25)
    target:addMod(xi.mod.STR, 7)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.FOOD_ATTP, 20)
    target:addMod(xi.mod.FOOD_ATT_CAP, 150)
    target:addMod(xi.mod.FOOD_RATTP, 20)
    target:addMod(xi.mod.FOOD_RATT_CAP, 150)
    target:addMod(xi.mod.DEMON_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 25)
    target:delMod(xi.mod.STR, 7)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.FOOD_ATTP, 20)
    target:delMod(xi.mod.FOOD_ATT_CAP, 150)
    target:delMod(xi.mod.FOOD_RATTP, 20)
    target:delMod(xi.mod.FOOD_RATT_CAP, 150)
    target:delMod(xi.mod.DEMON_KILLER, 5)
end

return itemObject
