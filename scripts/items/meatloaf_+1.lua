-----------------------------------
-- ID: 5690
-- Item: Meatloaf +1
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- Strength 6
-- Agility 2
-- Intelligence -3
-- Attack 18% Cap 95
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 6)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.FOOD_ATTP, 18)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 95)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
