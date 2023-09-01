-----------------------------------
-- ID: 5753
-- Item: Pot-au-feu
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 4
-- Agility 4
-- Intelligence -3
-- Ranged Attk % 16 Cap 65
-- Ranged ACC % 11 Cap 55
-- Enmity -3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5753)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.FOOD_RATTP, 16)
    target:addMod(xi.mod.FOOD_RATT_CAP, 65)
    target:addMod(xi.mod.FOOD_RACCP, 11)
    target:addMod(xi.mod.FOOD_RACC_CAP, 55)
    target:addMod(xi.mod.ENMITY, -3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.FOOD_RATTP, 16)
    target:delMod(xi.mod.FOOD_RATT_CAP, 65)
    target:delMod(xi.mod.FOOD_RACCP, 11)
    target:delMod(xi.mod.FOOD_RACC_CAP, 55)
    target:delMod(xi.mod.ENMITY, -3)
end

return itemObject
