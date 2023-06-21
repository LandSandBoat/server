-----------------------------------
-- ID: 5150
-- Item: plate_of_tuna_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 20
-- Dexterity 3
-- Charisma 5
-- Accuracy % 15 (cap 72)
-- Ranged ACC % 15 (cap 72)
-- Sleep Resist 1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5150)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.CHR, 5)
    target:addMod(xi.mod.FOOD_ACCP, 15)
    target:addMod(xi.mod.FOOD_ACC_CAP, 72)
    target:addMod(xi.mod.FOOD_RACCP, 15)
    target:addMod(xi.mod.FOOD_RACC_CAP, 72)
    target:addMod(xi.mod.SLEEPRES, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.CHR, 5)
    target:delMod(xi.mod.FOOD_ACCP, 15)
    target:delMod(xi.mod.FOOD_ACC_CAP, 72)
    target:delMod(xi.mod.FOOD_RACCP, 15)
    target:delMod(xi.mod.FOOD_RACC_CAP, 72)
    target:delMod(xi.mod.SLEEPRES, 1)
end

return itemObject
