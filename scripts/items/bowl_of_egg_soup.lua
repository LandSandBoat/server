-----------------------------------
-- ID: 4417
-- Item: Bowl of Egg Soup
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health % 6
-- Health Cap 30
-- Magic 5
-- Health Regen While Healing 5
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 10800, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HPP, 6)
    effect:addMod(xi.mod.FOOD_HP_CAP, 30)
    effect:addMod(xi.mod.FOOD_MP, 5)
    effect:addMod(xi.mod.HPHEAL, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
