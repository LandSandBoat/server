-----------------------------------
-- ID: 5678
-- Item: Mushroom Salad
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- MP 14% Cap 85
-- Agility 6
-- Mind 6
-- Strength -5
-- Vitality -5
-- Ranged Accuracy +15
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5678)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 14)
    target:addMod(xi.mod.FOOD_MP_CAP, 85)
    target:addMod(xi.mod.AGI, 6)
    target:addMod(xi.mod.MND, 6)
    target:addMod(xi.mod.STR, -5)
    target:addMod(xi.mod.VIT, -5)
    target:addMod(xi.mod.RACC, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 14)
    target:delMod(xi.mod.FOOD_MP_CAP, 85)
    target:delMod(xi.mod.AGI, 6)
    target:delMod(xi.mod.MND, 6)
    target:delMod(xi.mod.STR, -5)
    target:delMod(xi.mod.VIT, -5)
    target:delMod(xi.mod.RACC, 15)
end

return itemObject
