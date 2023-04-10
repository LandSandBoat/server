-----------------------------------
-- ID: 5156
-- Item: porcupine_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP 55
-- Strength 6
-- Vitality 2
-- Intelligence -3
-- Mind 3
-- HP recovered while healing 2
-- MP recovered while healing 2
-- Accuracy 5
-- Attack % 18 (cap 95)
-- Ranged Attack % 18 (cap 95)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5156)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 55)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.MND, 3)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.ACC, 5)
    target:addMod(xi.mod.FOOD_ATTP, 18)
    target:addMod(xi.mod.FOOD_ATT_CAP, 95)
    target:addMod(xi.mod.FOOD_RATTP, 18)
    target:addMod(xi.mod.FOOD_RATT_CAP, 95)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 55)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.MND, 3)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.ACC, 5)
    target:delMod(xi.mod.FOOD_ATTP, 18)
    target:delMod(xi.mod.FOOD_ATT_CAP, 95)
    target:delMod(xi.mod.FOOD_RATTP, 18)
    target:delMod(xi.mod.FOOD_RATT_CAP, 95)
end

return itemObject
