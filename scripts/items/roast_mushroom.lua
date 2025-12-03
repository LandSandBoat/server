-----------------------------------
-- ID: 4410
-- Item: roast_mushroom
-- Food Effect: 30minutes, All Races
-----------------------------------
-- Magic Points 10
-- Strength -1
-- Mind 3
-- Enmity -1
-- MP Recovered While Healing 2
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
    effect:addMod(xi.mod.FOOD_MP, 10)
    effect:addMod(xi.mod.STR, -1)
    effect:addMod(xi.mod.MND, 3)
    effect:addMod(xi.mod.ENMITY, -1)
    effect:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
