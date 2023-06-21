-----------------------------------
-- ID: 6469
-- Item: plate_of_sublime_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +45
-- MP +25
-- STR +7
-- DEX +8
-- MND -4
-- CHR +7
-- Accuracy +11% (cap 105)
-- Ranged Accuracy +11% (cap 105)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6469)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 45)
    target:addMod(xi.mod.MP, 25)
    target:addMod(xi.mod.STR, 7)
    target:addMod(xi.mod.DEX, 8)
    target:addMod(xi.mod.MND, -4)
    target:addMod(xi.mod.CHR, 7)
    target:addMod(xi.mod.FOOD_ACCP, 11)
    target:addMod(xi.mod.FOOD_ACC_CAP, 105)
    target:addMod(xi.mod.FOOD_RACCP, 11)
    target:addMod(xi.mod.FOOD_RACC_CAP, 105)
    target:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 45)
    target:delMod(xi.mod.MP, 25)
    target:delMod(xi.mod.STR, 7)
    target:delMod(xi.mod.DEX, 8)
    target:delMod(xi.mod.MND, -4)
    target:delMod(xi.mod.CHR, 7)
    target:delMod(xi.mod.FOOD_ACCP, 11)
    target:delMod(xi.mod.FOOD_ACC_CAP, 105)
    target:delMod(xi.mod.FOOD_RACCP, 11)
    target:delMod(xi.mod.FOOD_RACC_CAP, 105)
    target:delMod(xi.mod.SLEEPRES, 2)
end

return itemObject
