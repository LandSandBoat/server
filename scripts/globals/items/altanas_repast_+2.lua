-----------------------------------
-- ID: 6540
-- Item: Altanas Repast +2
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- AoE:
-- STR+20
-- DEX+20
-- VIT+20
-- AGI+20
-- INT+20
-- MND+20
-- CHR+20
-- Accuracy+90
-- Attack+90
-- R. Accuracy+90
-- R. Attack+90
-- M. Accuracy+90
-- "M. Atk. Bonus"+20
-- "M. Def. Bonus"+5
-- Evasion+90
-- DEF+90
-- M. Evasion+90
-- "Store TP"+8
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
            member:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 6540)
        end
    end)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 20)
    target:addMod(xi.mod.DEX, 20)
    target:addMod(xi.mod.VIT, 20)
    target:addMod(xi.mod.AGI, 20)
    target:addMod(xi.mod.INT, 20)
    target:addMod(xi.mod.MND, 20)
    target:addMod(xi.mod.CHR, 20)
    target:addMod(xi.mod.ACC, 90)
    target:addMod(xi.mod.ATT, 90)
    target:addMod(xi.mod.RACC, 90)
    target:addMod(xi.mod.RATT, 90)
    target:addMod(xi.mod.MACC, 90)
    target:addMod(xi.mod.MATT, 20)
    target:addMod(xi.mod.MDEF, 5)
    target:addMod(xi.mod.EVA, 90)
    target:addMod(xi.mod.DEF, 90)
    target:addMod(xi.mod.MEVA, 90)
    target:addMod(xi.mod.STORETP, 8)
    target:addPetMod(xi.mod.STR, 20)
    target:addPetMod(xi.mod.DEX, 20)
    target:addPetMod(xi.mod.VIT, 20)
    target:addPetMod(xi.mod.AGI, 20)
    target:addPetMod(xi.mod.INT, 20)
    target:addPetMod(xi.mod.MND, 20)
    target:addPetMod(xi.mod.CHR, 20)
    target:addPetMod(xi.mod.ACC, 90)
    target:addPetMod(xi.mod.ATT, 90)
    target:addPetMod(xi.mod.RACC, 90)
    target:addPetMod(xi.mod.RATT, 90)
    target:addPetMod(xi.mod.MACC, 90)
    target:addPetMod(xi.mod.MATT, 20)
    target:addPetMod(xi.mod.MDEF, 5)
    target:addPetMod(xi.mod.EVA, 90)
    target:addPetMod(xi.mod.DEF, 90)
    target:addPetMod(xi.mod.MEVA, 90)
    target:addPetMod(xi.mod.STORETP, 8)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 20)
    target:delMod(xi.mod.DEX, 20)
    target:delMod(xi.mod.VIT, 20)
    target:delMod(xi.mod.AGI, 20)
    target:delMod(xi.mod.INT, 20)
    target:delMod(xi.mod.MND, 20)
    target:delMod(xi.mod.CHR, 20)
    target:delMod(xi.mod.ACC, 90)
    target:delMod(xi.mod.ATT, 90)
    target:delMod(xi.mod.RACC, 90)
    target:delMod(xi.mod.RATT, 90)
    target:delMod(xi.mod.MACC, 90)
    target:delMod(xi.mod.MATT, 20)
    target:delMod(xi.mod.MDEF, 5)
    target:delMod(xi.mod.EVA, 90)
    target:delMod(xi.mod.DEF, 90)
    target:delMod(xi.mod.MEVA, 90)
    target:delMod(xi.mod.STORETP, 8)
    target:delPetMod(xi.mod.STR, 20)
    target:delPetMod(xi.mod.DEX, 20)
    target:delPetMod(xi.mod.VIT, 20)
    target:delPetMod(xi.mod.AGI, 20)
    target:delPetMod(xi.mod.INT, 20)
    target:delPetMod(xi.mod.MND, 20)
    target:delPetMod(xi.mod.CHR, 20)
    target:delPetMod(xi.mod.ACC, 90)
    target:delPetMod(xi.mod.ATT, 90)
    target:delPetMod(xi.mod.RACC, 90)
    target:delPetMod(xi.mod.RATT, 90)
    target:delPetMod(xi.mod.MACC, 90)
    target:delPetMod(xi.mod.MATT, 20)
    target:delPetMod(xi.mod.MDEF, 5)
    target:delPetMod(xi.mod.EVA, 90)
    target:delPetMod(xi.mod.DEF, 90)
    target:delPetMod(xi.mod.MEVA, 90)
    target:delPetMod(xi.mod.STORETP, 8)
end

return itemObject
