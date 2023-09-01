-----------------------------------
-- ID: 4484
-- Item: shall_shell
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Dexterity -5
-- Vitality 4
-- Defense % 16.4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_FISH)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4484)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, -5)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.FOOD_DEFP, 16.4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, -5)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.FOOD_DEFP, 16.4)
end

return itemObject
