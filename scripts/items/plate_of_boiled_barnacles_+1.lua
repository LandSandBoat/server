-----------------------------------
-- ID: 5981
-- Item: Plate of Boiled Barnacles +1
-- Food Effect: 60 Mins, All Races
-----------------------------------
-- Charisma -2
-- Defense % 26 Cap 135
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 3600, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.CHR, -2)
    effect:addMod(xi.mod.FOOD_DEFP, 26)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 135)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
