-----------------------------------
-- ID: 6213
-- Item: slice of margherita pizza
-- Food Effect: 30 minutes, all Races
-----------------------------------
-- HP +30
-- Accuracy+10% (Max. 8)
-- Attack+10% (Max. 10)
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
    effect:addMod(xi.mod.FOOD_ACCP, 10)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 8)
    effect:addMod(xi.mod.FOOD_ATTP, 10)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
