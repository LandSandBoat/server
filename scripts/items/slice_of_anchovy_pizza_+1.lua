-----------------------------------
-- ID: 6218
-- Item: slice of anchovy pizza +1
-- Food Effect: 60 minutes, all Races
-----------------------------------
-- HP +35
-- DEX +2
-- Accuracy +9% (Cap 16)
-- Attack +10% (Cap 21)
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
    effect:addMod(xi.mod.FOOD_HP, 35)
    effect:addMod(xi.mod.DEX, 2)
    effect:addMod(xi.mod.FOOD_ACCP, 9)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 16)
    effect:addMod(xi.mod.FOOD_ATTP, 10)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 21)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
