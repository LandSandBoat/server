-----------------------------------
-- ID: 4322
-- Item: dhalmel_pie_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 25
-- Strength 4
-- Agility 2
-- Vitality 1
-- Intelligence -2
-- Mind 1
-- Attack % 25
-- Attack Cap 50
-- Ranged ATT % 25
-- Ranged ATT Cap 50
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
    effect:addMod(xi.mod.FOOD_HP, 25)
    effect:addMod(xi.mod.STR, 4)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.VIT, 1)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.MND, 1)
    effect:addMod(xi.mod.FOOD_ATTP, 25)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 50)
    effect:addMod(xi.mod.FOOD_RATTP, 25)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 50)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
