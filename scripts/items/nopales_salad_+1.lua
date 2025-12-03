-----------------------------------
-- ID: 5702
-- Item: Nopales Salad +1
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Strength 2
-- Agility 7
-- Ranged Accuracy +25
-- Ranged Attack +15
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
    effect:addMod(xi.mod.STR, 2)
    effect:addMod(xi.mod.AGI, 7)
    effect:addMod(xi.mod.RACC, 25)
    effect:addMod(xi.mod.RATT, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
