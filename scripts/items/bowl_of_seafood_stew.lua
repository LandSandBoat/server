-----------------------------------
-- ID: 4561
-- Item: Bowl of Seafood Stew
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 20
-- Dexterity 1
-- Vitality 5
-- Defense % 25
-- Defense Cap 120
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
    effect:addMod(xi.mod.FOOD_HP, 20)
    effect:addMod(xi.mod.DEX, 1)
    effect:addMod(xi.mod.VIT, 5)
    effect:addMod(xi.mod.FOOD_DEFP, 25)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 120)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
