-----------------------------------
-- ID: 4329
-- Item: serving_of_newt_flambe
-- Food Effect: 240Min, All Races
-----------------------------------
-- Dexterity 4
-- Mind -3
-- Attack % 18
-- Attack Cap 65
-- Virus Resist 4
-- Curse Resist 4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4329)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.FOOD_ATTP, 18)
    target:addMod(xi.mod.FOOD_ATT_CAP, 65)
    target:addMod(xi.mod.VIRUSRES, 4)
    target:addMod(xi.mod.CURSERES, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.FOOD_ATTP, 18)
    target:delMod(xi.mod.FOOD_ATT_CAP, 65)
    target:delMod(xi.mod.VIRUSRES, 4)
    target:delMod(xi.mod.CURSERES, 4)
end

return itemObject
