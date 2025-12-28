-----------------------------------
-- ID: 5299
-- Item: dish_of_salsa
-- Food Effect: 3Min, All Races
-----------------------------------
-- Strength -1
-- Dexterity -1
-- Agility -1
-- Vitality -1
-- Intelligence -1
-- Mind -1
-- Sleep Resist 5
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, -1)
    effect:addMod(xi.mod.DEX, -1)
    effect:addMod(xi.mod.AGI, -1)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.INT, -1)
    effect:addMod(xi.mod.MND, -1)
    effect:addMod(xi.mod.SLEEPRES, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
