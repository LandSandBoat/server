-----------------------------------
-- ID: 6466
-- Item: bowl_of_miso_soup
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +7% (cap 50)
-- DEX +4
-- AGI +4
-- Accuracy +10% (cap 40)
-- Attack +10% (cap 40)
-- Ranged Accuracy +10% (cap 40)
-- Ranged Attack +10% (cap 40)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6466)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 7)
    target:addMod(xi.mod.FOOD_HP_CAP, 50)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 40)
    target:addMod(xi.mod.FOOD_RACCP, 10)
    target:addMod(xi.mod.FOOD_RACC_CAP, 40)
    target:addMod(xi.mod.FOOD_ATTP, 10)
    target:addMod(xi.mod.FOOD_ATT_CAP, 40)
    target:addMod(xi.mod.FOOD_RATTP, 10)
    target:addMod(xi.mod.FOOD_RATT_CAP, 40)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 7)
    target:delMod(xi.mod.FOOD_HP_CAP, 50)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 40)
    target:delMod(xi.mod.FOOD_RACCP, 10)
    target:delMod(xi.mod.FOOD_RACC_CAP, 40)
    target:delMod(xi.mod.FOOD_ATTP, 10)
    target:delMod(xi.mod.FOOD_ATT_CAP, 40)
    target:delMod(xi.mod.FOOD_RATTP, 10)
    target:delMod(xi.mod.FOOD_RATT_CAP, 40)
end

return itemObject
