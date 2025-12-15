-----------------------------------
-- ID: 6211
-- Item: slice of marinara pizza
-- Food Effect: 30 minutes, all Races
-----------------------------------
-- HP +20
-- Accuracy +10% (54)
-- Attack +20% (cap 50 @ 250 base attack)
-- Undead Killer
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
    effect:addMod(xi.mod.FOOD_HP, 20)
    effect:addMod(xi.mod.FOOD_ACCP, 10)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 54)
    effect:addMod(xi.mod.FOOD_ATTP, 20)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 50)
    effect:addMod(xi.mod.UNDEAD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
