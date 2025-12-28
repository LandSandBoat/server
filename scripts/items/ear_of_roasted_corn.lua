-----------------------------------
-- ID: 4415
-- Item: ear_of_roasted_corn
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 6
-- Dexterity -1
-- Vitality 3
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
    effect:addMod(xi.mod.FOOD_HP, 6)
    effect:addMod(xi.mod.DEX, -1)
    effect:addMod(xi.mod.VIT, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
