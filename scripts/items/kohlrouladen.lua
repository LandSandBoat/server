-----------------------------------
-- ID: 5760
-- Item: kohlrouladen
-- Food Effect: 3hr, All Races
-----------------------------------
-- Strength 3
-- Agility 3
-- Intelligence -5
-- RACC +8% (cap 60)
-- RATT +14% (cap 65)
-- Enmity -4
-- Subtle Blow +5
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
    effect:addMod(xi.mod.STR, 3)
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.INT, -5)
    effect:addMod(xi.mod.FOOD_RACCP, 8)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 60)
    effect:addMod(xi.mod.FOOD_RATTP, 14)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 65)
    effect:addMod(xi.mod.ENMITY, -4)
    effect:addMod(xi.mod.SUBTLE_BLOW, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
