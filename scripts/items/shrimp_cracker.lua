-----------------------------------
-- ID: 5635
-- Item: shrimp_cracker
-- Food Effect: 3Min, All Races
-----------------------------------
-- Vitality 1
-- DEF +10
-- Amorph Killer 10
-- Resist Virus +10
-- HP Recovered While Healing 8
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5635)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.DEF, 10)
    target:addMod(xi.mod.AMORPH_KILLER, 10)
    target:addMod(xi.mod.VIRUSRES, 10)
    target:addMod(xi.mod.HPHEAL, 8)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.DEF, 10)
    target:delMod(xi.mod.AMORPH_KILLER, 10)
    target:delMod(xi.mod.VIRUSRES, 10)
    target:delMod(xi.mod.HPHEAL, 8)
end

return itemObject
