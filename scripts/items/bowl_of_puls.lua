-----------------------------------
-- ID: 4492
-- Item: bowl_of_puls
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Vitality 2
-- Dexterity -1
-- HP Recovered While Healing 3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4492)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.DEX, -1)
    target:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.DEX, -1)
    target:delMod(xi.mod.HPHEAL, 3)
end

return itemObject
