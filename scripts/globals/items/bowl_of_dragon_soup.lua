-----------------------------------
-- ID: 4549
-- Item: Bowl of Dragon Soup
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 20
-- Strength 7
-- Agility 2
-- Vitality 2
-- Intelligence -3
-- Health Regen While Healing 8
-- Attack % 22
-- Attack Cap 150
-- Ranged ATT % 22
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4549)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.STR, 7)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.HPHEAL, 8)
    target:addMod(xi.mod.FOOD_ATTP, 22)
    target:addMod(xi.mod.FOOD_ATT_CAP, 150)
    target:addMod(xi.mod.FOOD_RATTP, 22)
    target:addMod(xi.mod.FOOD_RATT_CAP, 150)
    target:addMod(xi.mod.DEMON_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.STR, 7)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.HPHEAL, 8)
    target:delMod(xi.mod.FOOD_ATTP, 22)
    target:delMod(xi.mod.FOOD_ATT_CAP, 150)
    target:delMod(xi.mod.FOOD_RATTP, 22)
    target:delMod(xi.mod.FOOD_RATT_CAP, 150)
    target:delMod(xi.mod.DEMON_KILLER, 5)
end

return itemObject
