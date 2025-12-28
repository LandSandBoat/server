-----------------------------------
-- ID: 4398
-- Item: fish_mithkabob
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 1
-- Vitality 2
-- Mind -1
-- Defense % 25
-- Defense Cap 90
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
    effect:addMod(xi.mod.DEX, 1)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.MND, -1)
    effect:addMod(xi.mod.FOOD_DEFP, 25)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 90)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
