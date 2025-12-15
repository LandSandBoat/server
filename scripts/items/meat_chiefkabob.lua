-----------------------------------
-- ID: 4574
-- Item: meat_chiefkabob
-- Food Effect: 60Min, All Races
-----------------------------------
-- Strength 5
-- Agility 1
-- Intelligence -2
-- Attack % 22
-- Attack Cap 65
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
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.FOOD_ATTP, 22)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 65)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
