-----------------------------------
-- ID: 6063
-- Item: fruit_parfait
-- Food Effect: 180 Min, All Races
-----------------------------------
-- MP+5% (Upper limit 50)
-- INT+3
-- MND+2
-- CHR+1
-- STR-3
-- MACC+3
-- MAB+6
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 6063)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 5)
    target:addMod(xi.mod.FOOD_MP_CAP, 50)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.MND, 2)
    target:addMod(xi.mod.CHR, 1)
    target:addMod(xi.mod.STR, -3)
    target:addMod(xi.mod.MACC, 3)
    target:addMod(xi.mod.MATT, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 5)
    target:delMod(xi.mod.FOOD_MP_CAP, 50)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.MND, 2)
    target:delMod(xi.mod.CHR, 1)
    target:delMod(xi.mod.STR, -3)
    target:delMod(xi.mod.MACC, 3)
    target:delMod(xi.mod.MATT, 6)
end

return itemObject
