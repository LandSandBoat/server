-----------------------------------
-- ID: 5151
-- Item: plate_of_urchin_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 40
-- Strength 1
-- Vitality 5
-- Accuracy % 15 (cap 72)
-- Ranged ACC % 15 (cap 72)
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
    effect:addMod(xi.mod.FOOD_HP, 40)
    effect:addMod(xi.mod.STR, 1)
    effect:addMod(xi.mod.VIT, 5)
    effect:addMod(xi.mod.FOOD_ACCP, 15)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 72)
    effect:addMod(xi.mod.FOOD_RACCP, 15)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 72)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
