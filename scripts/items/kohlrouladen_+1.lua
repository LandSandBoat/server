-----------------------------------
-- ID: 5761
-- Item: kohlrouladen +1
-- Food Effect: 4hr, All Races
-----------------------------------
-- Strength 4
-- Agility 4
-- Intelligence -4
-- RACC +10% (cap 65)
-- RATT +16% (cap 70)
-- Enmity -5
-- Subtle Blow +6
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
    effect:addMod(xi.mod.STR, 4)
    effect:addMod(xi.mod.AGI, 4)
    effect:addMod(xi.mod.INT, -4)
    effect:addMod(xi.mod.FOOD_RACCP, 10)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 65)
    effect:addMod(xi.mod.FOOD_RATTP, 16)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 70)
    effect:addMod(xi.mod.ENMITY, -5)
    effect:addMod(xi.mod.SUBTLE_BLOW, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
