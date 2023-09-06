-----------------------------------
-- ID: 6565
-- Item: Persikos Snow Cone
-- Food Effect: 5 minutes, all Races
-----------------------------------
-- MP +35% (Max. 50 @ 143 Base MP)
-- INT +3
-- [Element: Air]+5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 6565)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 35)
    target:addMod(xi.mod.FOOD_MP_CAP, 50)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.WIND_MEVA, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 35)
    target:delMod(xi.mod.FOOD_MP_CAP, 50)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.WIND_MEVA, 5)
end

return itemObject
