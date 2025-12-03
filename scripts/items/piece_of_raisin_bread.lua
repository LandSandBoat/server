-----------------------------------
-- ID: 4546
-- Item: piece_of_raisin_bread
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 20
-- Dexterity -1
-- Vitality 4
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
    effect:addMod(xi.mod.DEX, -1)
    effect:addMod(xi.mod.VIT, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
