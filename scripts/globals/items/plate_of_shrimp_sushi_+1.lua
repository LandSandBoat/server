-----------------------------------
-- ID: 5692
-- Item: plate_of_shrimp_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Vitality 2
-- Defense 10
-- Accuracy % 15 (cap 72)
-- Ranged Accuracy % 15 (cap 72)
-- Resist Sleep +2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5692)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.DEF, 10)
    target:addMod(xi.mod.FOOD_ACCP, 15)
    target:addMod(xi.mod.FOOD_ACC_CAP, 72)
    target:addMod(xi.mod.FOOD_RACCP, 15)
    target:addMod(xi.mod.FOOD_RACC_CAP, 72)
    target:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.DEF, 10)
    target:delMod(xi.mod.FOOD_ACCP, 15)
    target:delMod(xi.mod.FOOD_ACC_CAP, 72)
    target:delMod(xi.mod.FOOD_RACCP, 15)
    target:delMod(xi.mod.FOOD_RACC_CAP, 72)
    target:delMod(xi.mod.SLEEPRES, 2)
end

return itemObject
