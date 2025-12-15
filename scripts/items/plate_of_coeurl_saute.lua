-----------------------------------
-- ID: 4548
-- Item: plate_of_coeurl_sautee
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 5
-- Agility 1
-- Intelligence -2
-- Attack % 20
-- Attack Cap 75
-- Ranged ATT % 20
-- Ranged ATT Cap 75
-- Stun Resist 4
-- HP recovered while healing +1
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
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.FOOD_ATTP, 20)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 75)
    effect:addMod(xi.mod.FOOD_RATTP, 20)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 75)
    effect:addMod(xi.mod.STUNRES, 4)
    effect:addMod(xi.mod.HPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
