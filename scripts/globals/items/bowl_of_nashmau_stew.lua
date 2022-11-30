-----------------------------------
-- ID: 5595
-- Item: Bowl of Nashmau Stew
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- MP -100
-- Vitality -10
-- Agility -10
-- Intelligence -10
-- Mind -10
-- Charisma -10
-- Accuracy +15% Cap 25
-- Attack +18% Cap 60
-- Defense -100
-- Evasion -100
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5595)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, -100)
    target:addMod(xi.mod.VIT, -10)
    target:addMod(xi.mod.AGI, -10)
    target:addMod(xi.mod.INT, -10)
    target:addMod(xi.mod.MND, -10)
    target:addMod(xi.mod.CHR, -10)
    target:addMod(xi.mod.FOOD_ACCP, 15)
    target:addMod(xi.mod.FOOD_ACC_CAP, 25)
    target:addMod(xi.mod.FOOD_ATTP, 18)
    target:addMod(xi.mod.FOOD_ATT_CAP, 60)
    target:addMod(xi.mod.DEF, -100)
    target:addMod(xi.mod.EVA, -100)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, -100)
    target:delMod(xi.mod.VIT, -10)
    target:delMod(xi.mod.AGI, -10)
    target:delMod(xi.mod.INT, -10)
    target:delMod(xi.mod.MND, -10)
    target:delMod(xi.mod.CHR, -10)
    target:delMod(xi.mod.FOOD_ACCP, 15)
    target:delMod(xi.mod.FOOD_ACC_CAP, 25)
    target:delMod(xi.mod.FOOD_ATTP, 18)
    target:delMod(xi.mod.FOOD_ATT_CAP, 60)
    target:delMod(xi.mod.DEF, -100)
    target:delMod(xi.mod.EVA, -100)
end

return itemObject
