-----------------------------------
-- ID: 5583
-- Item: plate_of_patlican_salata_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- Agility 5
-- Vitality -2
-- Evasion +7
-- hHP +3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5583)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 5)
    target:addMod(xi.mod.VIT, -2)
    target:addMod(xi.mod.EVA, 7)
    target:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 5)
    target:delMod(xi.mod.VIT, -2)
    target:delMod(xi.mod.EVA, 7)
    target:delMod(xi.mod.HPHEAL, 3)
end

return itemObject
