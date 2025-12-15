-----------------------------------
-- ID: 4446
-- Item: pumpkin_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 40
-- Agility -1
-- Intelligence 3
-- Charisma -2
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
    effect:addMod(xi.mod.FOOD_MP, 40)
    effect:addMod(xi.mod.AGI, -1)
    effect:addMod(xi.mod.INT, 3)
    effect:addMod(xi.mod.CHR, -2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
