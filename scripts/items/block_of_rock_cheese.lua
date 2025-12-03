-----------------------------------
-- ID: 4593
-- Item: Block of Rock Cheese
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 6
-- Health Cap 45
-- HP Recovered while healing 1
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
    effect:addMod(xi.mod.FOOD_HPP, 6)
    effect:addMod(xi.mod.FOOD_HP_CAP, 45)
    effect:addMod(xi.mod.HPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
