-----------------------------------
-- ID: 5927
-- Item: Cup of Caravan Tea
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- HP 22
-- MP 32
-- Charisma 6
-- Intelligence 4
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
    effect:addMod(xi.mod.FOOD_HP, 22)
    effect:addMod(xi.mod.FOOD_MP, 32)
    effect:addMod(xi.mod.CHR, 6)
    effect:addMod(xi.mod.INT, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
