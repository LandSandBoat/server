-----------------------------------
-- ID: 4284
-- Item: Bowl of Tender Navarin
-- Food Effect: 240Min, All Races
-----------------------------------
-- Health % 3 (cap 130)
-- Strength 3
-- Agility 1
-- Vitality 1
-- Intelligence -1
-- Attack % 27 (cap 35)
-- Ranged ATT % 27 (cap 35)
-- Evasion 5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4284)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 3)
    target:addMod(xi.mod.FOOD_HP_CAP, 130)
    target:addMod(xi.mod.STR, 3)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.FOOD_ATTP, 27)
    target:addMod(xi.mod.FOOD_ATT_CAP, 35)
    target:addMod(xi.mod.EVA, 5)
    target:addMod(xi.mod.FOOD_RATTP, 27)
    target:addMod(xi.mod.FOOD_RATT_CAP, 35)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 3)
    target:delMod(xi.mod.FOOD_HP_CAP, 130)
    target:delMod(xi.mod.STR, 3)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.FOOD_ATTP, 27)
    target:delMod(xi.mod.FOOD_ATT_CAP, 35)
    target:delMod(xi.mod.EVA, 5)
    target:delMod(xi.mod.FOOD_RATTP, 27)
    target:delMod(xi.mod.FOOD_RATT_CAP, 35)
end

return itemObject
