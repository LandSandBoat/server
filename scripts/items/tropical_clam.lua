-----------------------------------
-- ID: 5124
-- Item: Tropical Clam
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Vitality 4
-- Dexterity -5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_FISH)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5124)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.DEX, -5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.DEX, -5)
end

return itemObject
