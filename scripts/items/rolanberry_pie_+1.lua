-----------------------------------
-- ID: 4339
-- Item: rolanberry_pie_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Magic 60
-- Intelligence 3
-- MP Regen While Healing 1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4339)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 60)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 60)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
