-----------------------------------
-- ID: 6458
-- Item: bowl_of_soy_ramen
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +50
-- STR +5
-- VIT +5
-- AGI +3
-- Attack +10% (cap 170)
-- Ranged Attack +10% (cap 170)
-- Resist Slow +10
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6458)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 50)
    target:addMod(xi.mod.STR, 5)
    target:addMod(xi.mod.VIT, 5)
    target:addMod(xi.mod.AGI, 3)
    target:addMod(xi.mod.FOOD_ATTP, 10)
    target:addMod(xi.mod.FOOD_ATT_CAP, 170)
    target:addMod(xi.mod.FOOD_RATTP, 10)
    target:addMod(xi.mod.FOOD_RATT_CAP, 170)
    target:addMod(xi.mod.SLOWRES, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 50)
    target:delMod(xi.mod.STR, 5)
    target:delMod(xi.mod.VIT, 5)
    target:delMod(xi.mod.AGI, 3)
    target:delMod(xi.mod.FOOD_ATTP, 10)
    target:delMod(xi.mod.FOOD_ATT_CAP, 170)
    target:delMod(xi.mod.FOOD_RATTP, 10)
    target:delMod(xi.mod.FOOD_RATT_CAP, 170)
    target:delMod(xi.mod.SLOWRES, 10)
end

return itemObject
