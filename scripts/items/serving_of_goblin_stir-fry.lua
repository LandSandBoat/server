-----------------------------------
-- ID: 5143
-- Item: serving_of_goblin_stir-fry
-- Food Effect: 180Min, All Races
-----------------------------------
-- Agility 5
-- Vitality 2
-- Charisma -5
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
    effect:addMod(xi.mod.AGI, 5)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.CHR, -5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
