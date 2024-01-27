-----------------------------------
-- ID: 4533
-- Item: Bowl of Delicious Puls
-- Food Effect: 240Min, All Races
-----------------------------------
-- Dexterity -1
-- Vitality 3
-- Health Regen While Healing 5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4533)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, -1)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.HPHEAL, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, -1)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.HPHEAL, 5)
end

return itemObject
