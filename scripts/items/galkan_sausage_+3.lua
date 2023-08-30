-----------------------------------
-- ID: 5861
-- Item: galkan_sausage_+3
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 6
-- Intelligence -7
-- Attack 12
-- Ranged Attack 12
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5861)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.INT, -7)
    target:addMod(xi.mod.ATT, 12)
    target:addMod(xi.mod.RATT, 12)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.INT, -7)
    target:delMod(xi.mod.ATT, 12)
    target:delMod(xi.mod.RATT, 12)
end

return itemObject
