-----------------------------------
-- ID: 4549
-- Item: Bowl of Dragon Soup
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 20
-- Strength 7
-- Agility 2
-- Vitality 2
-- Intelligence -3
-- Health Regen While Healing 8
-- Attack % 22
-- Attack Cap 150
-- Ranged ATT % 22
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
    effect:addMod(xi.mod.FOOD_HP, 20)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.HPHEAL, 8)
    effect:addMod(xi.mod.FOOD_ATTP, 22)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 150)
    effect:addMod(xi.mod.FOOD_RATTP, 22)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 150)
    effect:addMod(xi.mod.DEMON_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
