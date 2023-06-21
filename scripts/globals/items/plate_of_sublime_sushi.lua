-----------------------------------
-- ID: 6468
-- Item: plate_of_sublime_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +40
-- MP +20
-- STR +6
-- DEX +7
-- MND -3
-- CHR +6
-- Accuracy +10% (cap 100)
-- Ranged Accuracy +10% (cap 100)
-- Resist Sleep +1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6468)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 40)
    target:addMod(xi.mod.MP, 20)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.DEX, 7)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.CHR, 6)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 100)
    target:addMod(xi.mod.FOOD_RACCP, 10)
    target:addMod(xi.mod.FOOD_RACC_CAP, 100)
    target:addMod(xi.mod.SLEEPRES, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 40)
    target:delMod(xi.mod.MP, 20)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.DEX, 7)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.CHR, 6)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 100)
    target:delMod(xi.mod.FOOD_RACCP, 10)
    target:delMod(xi.mod.FOOD_RACC_CAP, 100)
    target:delMod(xi.mod.SLEEPRES, 1)
end

return itemObject
