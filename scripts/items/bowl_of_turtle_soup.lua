-----------------------------------
-- ID: 4418
-- Item: Turtle Soup
-- Food Effect: 3hours, All Races
-----------------------------------
-- HP + 10% (200 Cap)
-- Dexterity +4
-- Vitality +6
-- Mind -3
-- HP Recovered While Healing +5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4418)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 200)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.VIT, 6)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.HPHEAL, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 200)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.VIT, 6)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.HPHEAL, 5)
end

return itemObject
