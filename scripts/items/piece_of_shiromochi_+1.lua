-----------------------------------
-- ID: 6259
-- Item: piece_of_shiromochi_+1
-- Food Effect: 60 Min, All Races
-----------------------------------
-- HP + 30 VIT + 4 (Pet & Master)
-- Accuracy/Ranged Accuracy +15% (cap 74 on master, cap 114 on pet)
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
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.FOOD_ACCP, 15)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 74)
    effect:addMod(xi.mod.FOOD_RACCP, 15)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 74)
    target:addPetMod(xi.mod.FOOD_HP, 30)
    target:addPetMod(xi.mod.VIT, 4)
    target:addPetMod(xi.mod.FOOD_ACCP, 15)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 114)
    target:addPetMod(xi.mod.FOOD_RACCP, 15)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 114)
end

itemObject.onEffectLose = function(target, effect)
    target:delPetMod(xi.mod.FOOD_HP, 30)
    target:delPetMod(xi.mod.VIT, 4)
    target:delPetMod(xi.mod.FOOD_ACCP, 15)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 114)
    target:delPetMod(xi.mod.FOOD_RACCP, 15)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 114)
end

return itemObject
