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
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:forMembersInRange(30, function(member)
        if not member:hasStatusEffect(xi.effect.FOOD) then
            member:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
        end
    end)
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 10)
    effect:addMod(xi.mod.DEX, 10)
    effect:addMod(xi.mod.VIT, 10)
    effect:addMod(xi.mod.AGI, 10)
    effect:addMod(xi.mod.INT, 10)
    effect:addMod(xi.mod.MND, 10)
    effect:addMod(xi.mod.CHR, 10)
    effect:addMod(xi.mod.ACC, 70)
    effect:addMod(xi.mod.ATT, 70)
    effect:addMod(xi.mod.RACC, 70)
    effect:addMod(xi.mod.RATT, 70)
    effect:addMod(xi.mod.MACC, 70)
    effect:addMod(xi.mod.MATT, 10)
    effect:addMod(xi.mod.MDEF, 3)
    effect:addMod(xi.mod.EVA, 70)
    effect:addMod(xi.mod.DEF, 70)
    effect:addMod(xi.mod.MEVA, 70)
    effect:addMod(xi.mod.STORETP, 6)
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
