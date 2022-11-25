-----------------------------------
-- ID: 4488
-- Item: jack-o-lantern
-- Food Effect: 180Min, All Races
-----------------------------------
-- Charisma -10
-- Accuracy 10
-- Ranged Acc 10
-- Evasion 10
-- Arcana Killer 4
-- Dark Res 25
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4488)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CHR, -10)
    target:addMod(xi.mod.ACC, 10)
    target:addMod(xi.mod.RACC, 10)
    target:addMod(xi.mod.EVA, 10)
    target:addMod(xi.mod.ARCANA_KILLER, 4)
    target:addMod(xi.mod.DARK_MEVA, 25)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CHR, -10)
    target:delMod(xi.mod.ACC, 10)
    target:delMod(xi.mod.RACC, 10)
    target:delMod(xi.mod.EVA, 10)
    target:delMod(xi.mod.ARCANA_KILLER, 4)
    target:delMod(xi.mod.DARK_MEVA, 25)
end

return itemObject
