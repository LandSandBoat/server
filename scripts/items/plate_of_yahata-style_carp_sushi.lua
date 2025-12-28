-----------------------------------
-- ID: 5186
-- Item: plate_of_yahata-style_carp_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 2
-- Accuracy % 11 (cap 56)
-- HP Recovered While Healing 2
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
    effect:addMod(xi.mod.DEX, 2)
    effect:addMod(xi.mod.FOOD_ACCP, 11)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 56)
    effect:addMod(xi.mod.HPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
