-----------------------------------
-- ID: 5983
-- Item: Piscator's Skewer
-- Food Effect: 60 Mins, All Races
-----------------------------------
-- Dexterity 3
-- Vitality 4
-- Defense % 26 Cap 155
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, 3)
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.FOOD_DEFP, 26)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 155)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
