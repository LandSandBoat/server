-----------------------------------
-- ID: 5722
-- Item: plate_of_crab_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Vitality 2
-- Defense 15
-- Accuracy % 14 (cap 68)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5722)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.DEF, 15)
    target:addMod(xi.mod.FOOD_ACCP, 14)
    target:addMod(xi.mod.FOOD_ACC_CAP, 68)
    target:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.DEF, 15)
    target:delMod(xi.mod.FOOD_ACCP, 14)
    target:delMod(xi.mod.FOOD_ACC_CAP, 68)
    target:delMod(xi.mod.SLEEPRES, 2)
end

return itemObject
