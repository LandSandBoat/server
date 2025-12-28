-----------------------------------
-- ID: 5610
-- Item: hellsteak_+1
-- Food Effect: 240Min, All Races
-----------------------------------
-- Health 22
-- Strength 7
-- Intelligence -3
-- Health Regen While Healing 2
-- hMP +1
-- Attack % 20 (cap 150)
-- Ranged ATT % 20 (cap 150)
-- Dragon Killer 5
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 22)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 1)
    effect:addMod(xi.mod.FOOD_ATTP, 20)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 150)
    effect:addMod(xi.mod.FOOD_RATTP, 20)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 150)
    effect:addMod(xi.mod.DRAGON_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
