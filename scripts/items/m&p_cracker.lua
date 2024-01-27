-----------------------------------
-- ID: 5640
-- Item: M&P Cracker
-- Food Effect: 3Min, All Races
-----------------------------------
-- Vitality 5
-- Mind -5
-- Defense % 25
-- Attack Cap 154
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5640)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 5)
    target:addMod(xi.mod.MND, -5)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 154)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 5)
    target:delMod(xi.mod.MND, -5)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 154)
end

return itemObject
