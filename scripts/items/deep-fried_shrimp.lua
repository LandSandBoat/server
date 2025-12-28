-----------------------------------
-- ID: 6276
-- Item: deep-fried_shrimp
-- Food Effect: 30Min, All Races
-----------------------------------
-- VIT +3
-- Fire resistance +20
-- Accuracy +20% (cap 70)
-- Ranged Accuracy +20% (cap 70)
-- Subtle Blow +8
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.FIRE_MEVA, 20)
    effect:addMod(xi.mod.FOOD_ACCP, 20)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 70)
    effect:addMod(xi.mod.FOOD_RACCP, 20)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 70)
    effect:addMod(xi.mod.SUBTLE_BLOW, 8)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
