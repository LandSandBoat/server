-----------------------------------
-- ID: 4411
-- Item: dhalmel_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 25
-- Strength 4
-- Agility 2
-- Vitality 1
-- Intelligence -2
-- Mind 1
-- Attack % 25
-- Attack Cap 45
-- Ranged ATT % 25
-- Ranged ATT Cap 45
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4411)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 25)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.INT, -2)
    target:addMod(xi.mod.MND, 1)
    target:addMod(xi.mod.FOOD_ATTP, 25)
    target:addMod(xi.mod.FOOD_ATT_CAP, 45)
    target:addMod(xi.mod.FOOD_RATTP, 25)
    target:addMod(xi.mod.FOOD_RATT_CAP, 45)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 25)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.INT, -2)
    target:delMod(xi.mod.MND, 1)
    target:delMod(xi.mod.FOOD_ATTP, 25)
    target:delMod(xi.mod.FOOD_ATT_CAP, 45)
    target:delMod(xi.mod.FOOD_RATTP, 25)
    target:delMod(xi.mod.FOOD_RATT_CAP, 45)
end

return itemObject
