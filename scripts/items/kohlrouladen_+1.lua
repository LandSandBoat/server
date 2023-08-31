-----------------------------------
-- ID: 5761
-- Item: kohlrouladen
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
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5761)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.INT, -4)
    target:addMod(xi.mod.FOOD_RACCP, 10)
    target:addMod(xi.mod.FOOD_RACC_CAP, 65)
    target:addMod(xi.mod.FOOD_RATTP, 16)
    target:addMod(xi.mod.FOOD_RATT_CAP, 70)
    target:addMod(xi.mod.ENMITY, -5)
    target:addMod(xi.mod.SUBTLE_BLOW, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.INT, -4)
    target:delMod(xi.mod.FOOD_RACCP, 10)
    target:delMod(xi.mod.FOOD_RACC_CAP, 65)
    target:delMod(xi.mod.FOOD_RATTP, 16)
    target:delMod(xi.mod.FOOD_RATT_CAP, 70)
    target:delMod(xi.mod.ENMITY, -5)
    target:delMod(xi.mod.SUBTLE_BLOW, 6)
end

return itemObject
