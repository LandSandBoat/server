-----------------------------------
-- ID: 4270
-- Item: sweet_rice_cake
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP 17
-- Vitality 2
-- Intelligence 3
-- Mind 1
-- HP Recovered While Healing 2
-- MP Recovered While Healing 2
-- Evasion 5
-- Resist Silence 4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4270)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 17)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.MND, 1)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.EVA, 5)
    target:addMod(xi.mod.SILENCERES, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 17)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.MND, 1)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.EVA, 5)
    target:delMod(xi.mod.SILENCERES, 4)
end

return itemObject
