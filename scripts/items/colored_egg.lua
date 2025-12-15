-----------------------------------
-- ID: 4487
-- Item: colored_egg
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 20
-- Magic 20
-- Attack 3
-- Ranged Attack 2
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
    effect:addMod(xi.mod.FOOD_HP, 20)
    effect:addMod(xi.mod.FOOD_MP, 20)
    effect:addMod(xi.mod.ATT, 3)
    effect:addMod(xi.mod.RATT, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
