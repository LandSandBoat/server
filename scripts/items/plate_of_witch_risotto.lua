-----------------------------------
-- ID: 4330
-- Item: witch_risotto
-- Food Effect: 4hours, All Races
-----------------------------------
-- Magic Points 35
-- Strength -1
-- Vitality 3
-- Mind 3
-- MP Recovered While Healing 2
-- Enmity -4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4330)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 35)
    target:addMod(xi.mod.STR, -1)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.MND, 3)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.ENMITY, -4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 35)
    target:delMod(xi.mod.STR, -1)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.MND, 3)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.ENMITY, -4)
end

return itemObject
