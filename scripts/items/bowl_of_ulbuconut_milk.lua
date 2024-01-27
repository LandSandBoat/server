-----------------------------------
-- ID: 5976
-- Item: Bowl of Ulbuconut Milk
-- Food Effect: 3Min, All Races
-----------------------------------
-- Charisma +3
-- Vitality -2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5976)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CHR, 3)
    target:addMod(xi.mod.VIT, -2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CHR, 3)
    target:delMod(xi.mod.VIT, -2)
end

return itemObject
