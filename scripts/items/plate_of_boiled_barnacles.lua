-----------------------------------
-- ID: 5980
-- Item: Plate of Boiled Barnacles
-- Food Effect: 30 Mins, All Races
-----------------------------------
-- Charisma -3
-- Defense % 25 Cap 130
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
    effect:addMod(xi.mod.CHR, -3)
    effect:addMod(xi.mod.FOOD_DEFP, 25)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 130)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
