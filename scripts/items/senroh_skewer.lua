-----------------------------------
-- ID: 5982
-- Item: Senroh Skewer
-- Food Effect: 30 Mins, All Races
-----------------------------------
-- Dexterity 2
-- Vitality 3
-- Mind -1
-- Defense % 25 Cap 150
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5982)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 150)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 150)
end

return itemObject
