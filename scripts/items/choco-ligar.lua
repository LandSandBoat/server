-----------------------------------
-- ID: 5919
-- Item: Choco-ligar
-- Food Effect: 3 Min, All Races
-----------------------------------
-- Vitality 1
-- Speed 12.5%
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5919)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.MOVE, 13)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.MOVE, 13)
end

return itemObject
