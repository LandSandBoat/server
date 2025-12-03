-----------------------------------
-- ID: 4333
-- Item: witch_soup
-- Food Effect: 4hours, All Races
-----------------------------------
-- Magic Points 25
-- Strength -1
-- Mind 2
-- MP Recovered While Healing 1
-- Enmity -2
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_MP, 25)
    effect:addMod(xi.mod.STR, -1)
    effect:addMod(xi.mod.MND, 2)
    effect:addMod(xi.mod.MPHEAL, 1)
    effect:addMod(xi.mod.ENMITY, -2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
