-----------------------------------
-- ID: 6217
-- Item: slice of anchovy_pizza
-- Food Effect: 30 minutes, all Races
-----------------------------------
-- HP +30
-- DEX +1
-- Accuracy +9% (Cap 15)
-- Attack +10% (Cap 20)
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
    effect:addMod(xi.mod.FOOD_HP, 30)
    effect:addMod(xi.mod.DEX, 1)
    effect:addMod(xi.mod.FOOD_ACCP, 9)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 15)
    effect:addMod(xi.mod.FOOD_ATTP, 10)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 20)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
