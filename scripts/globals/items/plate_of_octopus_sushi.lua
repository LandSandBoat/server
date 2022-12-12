-----------------------------------
-- ID: 5693
-- Item: plate_of_octopus_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 1
-- Accuracy % 14 (cap 68)
-- Ranged Accuracy % 14 (cap 68)
-- Resist Sleep +1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5693)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 1)
    target:addMod(xi.mod.FOOD_ACCP, 14)
    target:addMod(xi.mod.FOOD_ACC_CAP, 68)
    target:addMod(xi.mod.FOOD_RACCP, 14)
    target:addMod(xi.mod.FOOD_RACC_CAP, 68)
    target:addMod(xi.mod.SLEEPRES, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 1)
    target:delMod(xi.mod.FOOD_ACCP, 14)
    target:delMod(xi.mod.FOOD_ACC_CAP, 68)
    target:delMod(xi.mod.FOOD_RACCP, 14)
    target:delMod(xi.mod.FOOD_RACC_CAP, 68)
    target:delMod(xi.mod.SLEEPRES, 1)
end

return itemObject
