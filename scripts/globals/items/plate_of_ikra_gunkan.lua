-----------------------------------
-- ID: 5219
-- Item: plate_of_ikra_gunkan
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 30
-- Magic 10
-- Dexterity 3
-- Mind -2
-- Accuracy % 18
-- Accuracy Cap 28
-- Ranged ACC % 18
-- Ranged ACC Cap 28
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5219)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.MP, 10)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.FOOD_ACCP, 18)
    target:addMod(xi.mod.FOOD_ACC_CAP, 28)
    target:addMod(xi.mod.FOOD_RACCP, 18)
    target:addMod(xi.mod.FOOD_RACC_CAP, 28)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.MP, 10)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.FOOD_ACCP, 18)
    target:delMod(xi.mod.FOOD_ACC_CAP, 28)
    target:delMod(xi.mod.FOOD_RACCP, 18)
    target:delMod(xi.mod.FOOD_RACC_CAP, 28)
end

return itemObject
