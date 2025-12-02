-----------------------------------
-- ID: 4535
-- Item: Boiled Crayfish
-- Food Effect: 30Min, All Races
-----------------------------------
-- defense % 30
-- defense % 25
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
    target:addMod(xi.mod.FOOD_DEFP, 30)
    target:addMod(xi.mod.FOOD_DEF_CAP, 25)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_DEFP, 30)
    target:delMod(xi.mod.FOOD_DEF_CAP, 25)
end

return itemObject
