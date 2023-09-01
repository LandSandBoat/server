-----------------------------------
-- ID: 6538
-- Item: Altanas Repast
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- AoE:
-- STR+10
-- DEX+10
-- VIT+10
-- AGI+10
-- INT+10
-- MND+10
-- CHR+10
-- Accuracy+70
-- Attack+70
-- R. Accuracy+70
-- R. Attack+70
-- M. Accuracy+70
-- "M. Atk. Bonus"+10
-- "M. Def. Bonus"+3
-- Evasion+70
-- DEF+70
-- M. Evasion+70
-- "Store TP"+6
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:forMembersInRange(30, function(member)
        if not member:hasStatusEffect(xi.effect.FOOD) then
            member:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 6538)
        end
    end)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 10)
    target:addMod(xi.mod.DEX, 10)
    target:addMod(xi.mod.VIT, 10)
    target:addMod(xi.mod.AGI, 10)
    target:addMod(xi.mod.INT, 10)
    target:addMod(xi.mod.MND, 10)
    target:addMod(xi.mod.CHR, 10)
    target:addMod(xi.mod.ACC, 70)
    target:addMod(xi.mod.ATT, 70)
    target:addMod(xi.mod.RACC, 70)
    target:addMod(xi.mod.RATT, 70)
    target:addMod(xi.mod.MACC, 70)
    target:addMod(xi.mod.MATT, 10)
    target:addMod(xi.mod.MDEF, 3)
    target:addMod(xi.mod.EVA, 70)
    target:addMod(xi.mod.DEF, 70)
    target:addMod(xi.mod.MEVA, 70)
    target:addMod(xi.mod.STORETP, 6)
    target:addPetMod(xi.mod.STR, 10)
    target:addPetMod(xi.mod.DEX, 10)
    target:addPetMod(xi.mod.VIT, 10)
    target:addPetMod(xi.mod.AGI, 10)
    target:addPetMod(xi.mod.INT, 10)
    target:addPetMod(xi.mod.MND, 10)
    target:addPetMod(xi.mod.CHR, 10)
    target:addPetMod(xi.mod.ACC, 70)
    target:addPetMod(xi.mod.ATT, 70)
    target:addPetMod(xi.mod.RACC, 70)
    target:addPetMod(xi.mod.RATT, 70)
    target:addPetMod(xi.mod.MACC, 70)
    target:addPetMod(xi.mod.MATT, 10)
    target:addPetMod(xi.mod.MDEF, 3)
    target:addPetMod(xi.mod.EVA, 70)
    target:addPetMod(xi.mod.DEF, 70)
    target:addPetMod(xi.mod.MEVA, 70)
    target:addPetMod(xi.mod.STORETP, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 10)
    target:delMod(xi.mod.DEX, 10)
    target:delMod(xi.mod.VIT, 10)
    target:delMod(xi.mod.AGI, 10)
    target:delMod(xi.mod.INT, 10)
    target:delMod(xi.mod.MND, 10)
    target:delMod(xi.mod.CHR, 10)
    target:delMod(xi.mod.ACC, 70)
    target:delMod(xi.mod.ATT, 70)
    target:delMod(xi.mod.RACC, 70)
    target:delMod(xi.mod.RATT, 70)
    target:delMod(xi.mod.MACC, 70)
    target:delMod(xi.mod.MATT, 10)
    target:delMod(xi.mod.MDEF, 3)
    target:delMod(xi.mod.EVA, 70)
    target:delMod(xi.mod.DEF, 70)
    target:delMod(xi.mod.MEVA, 70)
    target:delMod(xi.mod.STORETP, 6)
    target:delPetMod(xi.mod.STR, 10)
    target:delPetMod(xi.mod.DEX, 10)
    target:delPetMod(xi.mod.VIT, 10)
    target:delPetMod(xi.mod.AGI, 10)
    target:delPetMod(xi.mod.INT, 10)
    target:delPetMod(xi.mod.MND, 10)
    target:delPetMod(xi.mod.CHR, 10)
    target:delPetMod(xi.mod.ACC, 70)
    target:delPetMod(xi.mod.ATT, 70)
    target:delPetMod(xi.mod.RACC, 70)
    target:delPetMod(xi.mod.RATT, 70)
    target:delPetMod(xi.mod.MACC, 70)
    target:delPetMod(xi.mod.MATT, 10)
    target:delPetMod(xi.mod.MDEF, 3)
    target:delPetMod(xi.mod.EVA, 70)
    target:delPetMod(xi.mod.DEF, 70)
    target:delPetMod(xi.mod.MEVA, 70)
    target:delPetMod(xi.mod.STORETP, 6)
end

return itemObject
