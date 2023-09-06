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
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5760)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 3)
    target:addMod(xi.mod.AGI, 3)
    target:addMod(xi.mod.INT, -5)
    target:addMod(xi.mod.FOOD_RACCP, 8)
    target:addMod(xi.mod.FOOD_RACC_CAP, 60)
    target:addMod(xi.mod.FOOD_RATTP, 14)
    target:addMod(xi.mod.FOOD_RATT_CAP, 65)
    target:addMod(xi.mod.ENMITY, -4)
    target:addMod(xi.mod.SUBTLE_BLOW, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 3)
    target:delMod(xi.mod.AGI, 3)
    target:delMod(xi.mod.INT, -5)
    target:delMod(xi.mod.FOOD_RACCP, 8)
    target:delMod(xi.mod.FOOD_RACC_CAP, 60)
    target:delMod(xi.mod.FOOD_RATTP, 14)
    target:delMod(xi.mod.FOOD_RATT_CAP, 65)
    target:delMod(xi.mod.ENMITY, -4)
    target:delMod(xi.mod.SUBTLE_BLOW, 5)
end

return itemObject
