-----------------------------------
-- ID: 6342
-- Item: bean_daifuku_+1
-- Food Effect: 60 Min, All Races
-----------------------------------
-- HP +30
-- VIT +7
-- Accuracy +11% (cap 85)
-- Ranged Accuracy +11% (cap 85)
-- Pet:
-- HP +30
-- VIT +7
-- Accuracy +11% (cap 110)
-- Ranged Accuracy +11% (cap 110)
-- Defense +11% (cap 105)
-- Haste +4%
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 30)
    effect:addMod(xi.mod.VIT, 7)
    effect:addMod(xi.mod.FOOD_ACCP, 11)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 85)
    effect:addMod(xi.mod.FOOD_RACCP, 11)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 85)
    target:addPetMod(xi.mod.FOOD_HP, 30)
    target:addPetMod(xi.mod.VIT, 7)
    target:addPetMod(xi.mod.FOOD_ACCP, 11)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 110)
    target:addPetMod(xi.mod.FOOD_RACCP, 11)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 110)
    target:addPetMod(xi.mod.FOOD_DEFP, 11)
    target:addPetMod(xi.mod.FOOD_DEF_CAP, 105)
    target:addPetMod(xi.mod.HASTE_GEAR, 400)
end

itemObject.onEffectLose = function(target, effect)
    target:delPetMod(xi.mod.FOOD_HP, 30)
    target:delPetMod(xi.mod.VIT, 7)
    target:delPetMod(xi.mod.FOOD_ACCP, 11)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 110)
    target:delPetMod(xi.mod.FOOD_RACCP, 11)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 110)
    target:delPetMod(xi.mod.FOOD_DEFP, 11)
    target:delPetMod(xi.mod.FOOD_DEF_CAP, 105)
    target:delPetMod(xi.mod.HASTE_GEAR, 400)
end

return itemObject
