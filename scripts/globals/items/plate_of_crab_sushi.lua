-----------------------------------
-- ID: 5721
-- Item: plate_of_crab_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Vitality 1
-- Defense 10
-- Accuracy % 13 (cap 64)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5721)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.DEF, 10)
    target:addMod(xi.mod.FOOD_ACCP, 13)
    target:addMod(xi.mod.FOOD_ACC_CAP, 64)
    target:addMod(xi.mod.SLEEPRES, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.DEF, 10)
    target:delMod(xi.mod.FOOD_ACCP, 13)
    target:delMod(xi.mod.FOOD_ACC_CAP, 64)
    target:delMod(xi.mod.SLEEPRES, 1)
end

return itemObject
