-----------------------------------
-- ID: 5167
-- Item: coeurl_sub_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Magic 15
-- Strength 5
-- Agility 1
-- Intelligence -2
-- Health Regen While Healing 1
-- Attack % 22
-- Attack Cap 80
-- Ranged ATT % 22
-- Ranged ATT Cap 80
-- Sleep Resist 1
-- Stun Resist 4
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
    effect:addMod(xi.mod.FOOD_MP, 15)
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.HPHEAL, 1)
    effect:addMod(xi.mod.FOOD_ATTP, 22)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 80)
    effect:addMod(xi.mod.FOOD_RATTP, 22)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 80)
    effect:addMod(xi.mod.SLEEPRES, 1)
    effect:addMod(xi.mod.STUNRES, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
