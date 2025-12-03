-----------------------------------
-- ID: 5609
-- Item: hellsteak
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 20
-- Strength 6
-- Intelligence -2
-- Health Regen While Healing 2
-- hMP +1
-- Attack % 18 (cap 145)
-- Ranged ATT % 18 (cap 145)
-- Dragon Killer 5
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
    effect:addMod(xi.mod.STR, 6)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 1)
    effect:addMod(xi.mod.FOOD_ATTP, 18)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 145)
    effect:addMod(xi.mod.FOOD_RATTP, 18)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 145)
    effect:addMod(xi.mod.DRAGON_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
