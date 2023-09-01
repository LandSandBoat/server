-----------------------------------
-- ID: 4459
-- Item: nebimonite_bake
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 1
-- Vitality 2
-- Defense % 25
-- Defense Cap 70
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4459)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 1)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 70)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 1)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 70)
end

return itemObject
