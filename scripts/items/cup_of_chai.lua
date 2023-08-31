-----------------------------------
-- ID: 5570
-- Item: cup_of_chai
-- Food Effect: 180Min, All Races
-----------------------------------
-- Vitality -2
-- Charisma 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5570)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, -2)
    target:addMod(xi.mod.CHR, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, -2)
    target:delMod(xi.mod.CHR, 2)
end

return itemObject
