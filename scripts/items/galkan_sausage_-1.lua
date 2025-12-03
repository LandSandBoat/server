-----------------------------------
-- ID: 5862
-- Item: galkan_sausage_-1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength -3
-- Dexterity -3
-- Vitality -3
-- Agility -3
-- Mind -3
-- Intelligence -3
-- Charisma -3
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
    effect:addMod(xi.mod.STR, -3)
    effect:addMod(xi.mod.DEX, -3)
    effect:addMod(xi.mod.VIT, -3)
    effect:addMod(xi.mod.AGI, -3)
    effect:addMod(xi.mod.MND, -3)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.CHR, -3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
