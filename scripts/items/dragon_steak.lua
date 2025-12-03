-----------------------------------
-- ID: 4350
-- Item: dragon_steak
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 25
-- Strength 7
-- Intelligence -3
-- Health Regen While Healing 2
-- MP recovered while healing +2
-- Attack % 20
-- Attack Cap 150
-- Ranged ATT % 20
-- Ranged ATT Cap 150
-- Demon Killer 5
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
    effect:addMod(xi.mod.FOOD_HP, 25)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 2)
    effect:addMod(xi.mod.FOOD_ATTP, 20)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 150)
    effect:addMod(xi.mod.FOOD_RATTP, 20)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 150)
    effect:addMod(xi.mod.DEMON_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
