-----------------------------------
-- ID: 6064
-- Item: queens_crown
-- Food Effect: 240 Min, All Races
-----------------------------------
-- MP+6% (Upper limit 55)
-- INT+4
-- MND+3
-- CHR+2
-- STR-2
-- MACC+4
-- MAB+7
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 6064)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 6)
    target:addMod(xi.mod.FOOD_MP_CAP, 55)
    target:addMod(xi.mod.INT, 4)
    target:addMod(xi.mod.MND, 3)
    target:addMod(xi.mod.CHR, 2)
    target:addMod(xi.mod.STR, -2)
    target:addMod(xi.mod.MACC, 4)
    target:addMod(xi.mod.MATT, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 6)
    target:delMod(xi.mod.FOOD_MP_CAP, 55)
    target:delMod(xi.mod.INT, 4)
    target:delMod(xi.mod.MND, 3)
    target:delMod(xi.mod.CHR, 2)
    target:delMod(xi.mod.STR, -2)
    target:delMod(xi.mod.MACC, 4)
    target:delMod(xi.mod.MATT, 7)
end

return itemObject
