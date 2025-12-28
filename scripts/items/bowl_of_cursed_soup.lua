-----------------------------------
-- ID: 4235
-- Item: Bowl of Cursed Soup
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength -7
-- Dexterity -7
-- Agility -7
-- Vitality -7
-- Intelligence -7
-- Mind -7
-- Charisma -7
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
    effect:addMod(xi.mod.STR, -7)
    effect:addMod(xi.mod.DEX, -7)
    effect:addMod(xi.mod.AGI, -7)
    effect:addMod(xi.mod.VIT, -7)
    effect:addMod(xi.mod.INT, -7)
    effect:addMod(xi.mod.MND, -7)
    effect:addMod(xi.mod.CHR, -7)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
