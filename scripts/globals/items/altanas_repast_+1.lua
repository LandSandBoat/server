-----------------------------------
-- ID: 6539
-- Item: Altanas Repast +1
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- AoE:
-- STR+15
-- DEX+15
-- VIT+15
-- AGI+15
-- INT+15
-- MND+15
-- CHR+15
-- Accuracy+80
-- Attack+80
-- R. Accuracy+80
-- R. Attack+80
-- M. Accuracy+80
-- "M. Atk. Bonus"+15
-- "M. Def. Bonus"+4
-- Evasion+80
-- DEF+80
-- M. Evasion+80
-- "Store TP"+7
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
    target:forMembersInRange(30, function(member)
        if
            not member:hasStatusEffect(xi.effect.FOOD) and
            not member:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
        then
            member:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 6539)
        end
    end)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 15)
    target:addMod(xi.mod.DEX, 15)
    target:addMod(xi.mod.VIT, 15)
    target:addMod(xi.mod.AGI, 15)
    target:addMod(xi.mod.INT, 15)
    target:addMod(xi.mod.MND, 15)
    target:addMod(xi.mod.CHR, 15)
    target:addMod(xi.mod.ACC, 80)
    target:addMod(xi.mod.ATT, 80)
    target:addMod(xi.mod.RACC, 80)
    target:addMod(xi.mod.RATT, 80)
    target:addMod(xi.mod.MACC, 80)
    target:addMod(xi.mod.MATT, 15)
    target:addMod(xi.mod.MDEF, 4)
    target:addMod(xi.mod.EVA, 80)
    target:addMod(xi.mod.DEF, 80)
    target:addMod(xi.mod.MEVA, 80)
    target:addMod(xi.mod.STORETP, 7)
    target:addPetMod(xi.mod.STR, 15)
    target:addPetMod(xi.mod.DEX, 15)
    target:addPetMod(xi.mod.VIT, 15)
    target:addPetMod(xi.mod.AGI, 15)
    target:addPetMod(xi.mod.INT, 15)
    target:addPetMod(xi.mod.MND, 15)
    target:addPetMod(xi.mod.CHR, 15)
    target:addPetMod(xi.mod.ACC, 80)
    target:addPetMod(xi.mod.ATT, 80)
    target:addPetMod(xi.mod.RACC, 80)
    target:addPetMod(xi.mod.RATT, 80)
    target:addPetMod(xi.mod.MACC, 80)
    target:addPetMod(xi.mod.MATT, 15)
    target:addPetMod(xi.mod.MDEF, 4)
    target:addPetMod(xi.mod.EVA, 80)
    target:addPetMod(xi.mod.DEF, 80)
    target:addPetMod(xi.mod.MEVA, 80)
    target:addPetMod(xi.mod.STORETP, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 15)
    target:delMod(xi.mod.DEX, 15)
    target:delMod(xi.mod.VIT, 15)
    target:delMod(xi.mod.AGI, 15)
    target:delMod(xi.mod.INT, 15)
    target:delMod(xi.mod.MND, 15)
    target:delMod(xi.mod.CHR, 15)
    target:delMod(xi.mod.ACC, 80)
    target:delMod(xi.mod.ATT, 80)
    target:delMod(xi.mod.RACC, 80)
    target:delMod(xi.mod.RATT, 80)
    target:delMod(xi.mod.MACC, 80)
    target:delMod(xi.mod.MATT, 15)
    target:delMod(xi.mod.MDEF, 4)
    target:delMod(xi.mod.EVA, 80)
    target:delMod(xi.mod.DEF, 80)
    target:delMod(xi.mod.MEVA, 80)
    target:delMod(xi.mod.STORETP, 7)
    target:delPetMod(xi.mod.STR, 15)
    target:delPetMod(xi.mod.DEX, 15)
    target:delPetMod(xi.mod.VIT, 15)
    target:delPetMod(xi.mod.AGI, 15)
    target:delPetMod(xi.mod.INT, 15)
    target:delPetMod(xi.mod.MND, 15)
    target:delPetMod(xi.mod.CHR, 15)
    target:delPetMod(xi.mod.ACC, 80)
    target:delPetMod(xi.mod.ATT, 80)
    target:delPetMod(xi.mod.RACC, 80)
    target:delPetMod(xi.mod.RATT, 80)
    target:delPetMod(xi.mod.MACC, 80)
    target:delPetMod(xi.mod.MATT, 15)
    target:delPetMod(xi.mod.MDEF, 4)
    target:delPetMod(xi.mod.EVA, 80)
    target:delPetMod(xi.mod.DEF, 80)
    target:delPetMod(xi.mod.MEVA, 80)
    target:delPetMod(xi.mod.STORETP, 7)
end

return itemObject
