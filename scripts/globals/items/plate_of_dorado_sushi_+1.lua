-----------------------------------
-- ID: 5179
-- Item: plate_of_dorado_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Dexterity 5
-- Accuracy % 16
-- Accuracy Cap 76
-- Ranged ACC % 16
-- Ranged ACC Cap 76
-- Sleep Resist 2
-- Enmity 5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5179)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ENMITY, 5)
    target:addMod(xi.mod.DEX, 5)
    target:addMod(xi.mod.FOOD_ACCP, 16)
    target:addMod(xi.mod.FOOD_ACC_CAP, 76)
    target:addMod(xi.mod.FOOD_RACCP, 16)
    target:addMod(xi.mod.FOOD_RACC_CAP, 76)
    target:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ENMITY, 5)
    target:delMod(xi.mod.DEX, 5)
    target:delMod(xi.mod.FOOD_ACCP, 16)
    target:delMod(xi.mod.FOOD_ACC_CAP, 76)
    target:delMod(xi.mod.FOOD_RACCP, 16)
    target:delMod(xi.mod.FOOD_RACC_CAP, 76)
    target:delMod(xi.mod.SLEEPRES, 2)
end

return itemObject
