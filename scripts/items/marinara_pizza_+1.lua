-----------------------------------
-- ID: 5744
-- Item: marinara_pizza +1
-- Food Effect: 4 hours, all Races
-----------------------------------
-- HP +25
-- Attack +21% (cap 55)
-- Accuracy +11% (cap 58)
-- Undead Killer
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5744)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 25)
    target:addMod(xi.mod.FOOD_ATTP, 21)
    target:addMod(xi.mod.FOOD_ATT_CAP, 55)
    target:addMod(xi.mod.FOOD_ACCP, 11)
    target:addMod(xi.mod.FOOD_ACC_CAP, 58)
    target:addMod(xi.mod.UNDEAD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 25)
    target:delMod(xi.mod.FOOD_ATTP, 21)
    target:delMod(xi.mod.FOOD_ATT_CAP, 55)
    target:delMod(xi.mod.FOOD_ACCP, 11)
    target:delMod(xi.mod.FOOD_ACC_CAP, 58)
    target:delMod(xi.mod.UNDEAD_KILLER, 5)
end

return itemObject
