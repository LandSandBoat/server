-----------------------------------
-- ID: 4336
-- Item: sweet_baked_apple
-- Food Effect: 1hour, All Races
-----------------------------------
-- Magic Points 25
-- Intelligence 4
-- MP Recovered While Healing 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4336)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 25)
    target:addMod(xi.mod.INT, 4)
    target:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 25)
    target:delMod(xi.mod.INT, 4)
    target:delMod(xi.mod.MPHEAL, 2)
end

return itemObject
