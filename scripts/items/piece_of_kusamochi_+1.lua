-----------------------------------
-- ID: 6263
-- Item: kusamochi+1
-- Food Effect: 60 Min, All Races
-----------------------------------
-- HP + 30 (Pet & Master)
-- Vitality + 4 (Pet & Master)
-- Attack + 21% Cap: 77 (Pet & Master) Pet Cap: 120
-- Ranged Attack + 21% Cap: 77 (Pet & Master) Pet Cap: 120
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
    effect:addMod(xi.mod.FOOD_ATTP, 21)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 77)
    effect:addMod(xi.mod.FOOD_RATTP, 21)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 77)
    target:addPetMod(xi.mod.FOOD_HP, 30)
    target:addPetMod(xi.mod.VIT, 4)
    target:addPetMod(xi.mod.FOOD_ATTP, 21)
    target:addPetMod(xi.mod.FOOD_ATT_CAP, 120)
    target:addPetMod(xi.mod.FOOD_RATTP, 21)
    target:addPetMod(xi.mod.FOOD_RATT_CAP, 120)
end

itemObject.onEffectLose = function(target, effect)
    target:delPetMod(xi.mod.FOOD_HP, 30)
    target:delPetMod(xi.mod.VIT, 4)
    target:delPetMod(xi.mod.FOOD_ATTP, 21)
    target:delPetMod(xi.mod.FOOD_ATT_CAP, 120)
    target:delPetMod(xi.mod.FOOD_RATTP, 21)
    target:delPetMod(xi.mod.FOOD_RATT_CAP, 120)
end

return itemObject
