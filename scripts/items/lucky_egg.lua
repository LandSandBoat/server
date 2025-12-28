-----------------------------------
-- ID: 4600
-- Item: lucky_egg
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 14
-- Magic 14
-- Evasion 10
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
    effect:addMod(xi.mod.FOOD_HP, 14)
    effect:addMod(xi.mod.FOOD_MP, 14)
    effect:addMod(xi.mod.EVA, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
