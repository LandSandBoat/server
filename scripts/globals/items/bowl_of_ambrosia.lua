-----------------------------------
-- ID: 4511
-- Item: Bowl of Ambrosia
-- Food Effect: 240Min, All Races
-----------------------------------
-- HP +7
-- MP +7
-- STR +7
-- DEX +7
-- VIT +7
-- AGI +7
-- INT +7
-- MND +7
-- CHR +7
-- Accuracy +7
-- Ranged Accuracy +7
-- Attack +7
-- Ranged Attack +7
-- Evasion +7
-- Defense +7
-- HP recovered while healing +7
-- MP recovered while healing +7
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4511)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 7)
    target:addMod(xi.mod.MP, 7)
    target:addMod(xi.mod.STR, 7)
    target:addMod(xi.mod.DEX, 7)
    target:addMod(xi.mod.VIT, 7)
    target:addMod(xi.mod.AGI, 7)
    target:addMod(xi.mod.INT, 7)
    target:addMod(xi.mod.MND, 7)
    target:addMod(xi.mod.CHR, 7)
    target:addMod(xi.mod.ATT, 7)
    target:addMod(xi.mod.RATT, 7)
    target:addMod(xi.mod.ACC, 7)
    target:addMod(xi.mod.RACC, 7)
    target:addMod(xi.mod.HPHEAL, 7)
    target:addMod(xi.mod.MPHEAL, 7)
    target:addMod(xi.mod.DEF, 7)
    target:addMod(xi.mod.EVA, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 7)
    target:delMod(xi.mod.MP, 7)
    target:delMod(xi.mod.STR, 7)
    target:delMod(xi.mod.DEX, 7)
    target:delMod(xi.mod.VIT, 7)
    target:delMod(xi.mod.AGI, 7)
    target:delMod(xi.mod.INT, 7)
    target:delMod(xi.mod.MND, 7)
    target:delMod(xi.mod.CHR, 7)
    target:delMod(xi.mod.ATT, 7)
    target:delMod(xi.mod.RATT, 7)
    target:delMod(xi.mod.ACC, 7)
    target:delMod(xi.mod.RACC, 7)
    target:delMod(xi.mod.HPHEAL, 7)
    target:delMod(xi.mod.MPHEAL, 7)
    target:delMod(xi.mod.DEF, 7)
    target:delMod(xi.mod.EVA, 7)
end

return itemObject
