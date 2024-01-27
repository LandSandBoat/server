-----------------------------------
-- ID: 5299
-- Item: dish_of_salsa
-- Food Effect: 3Min, All Races
-----------------------------------
-- Strength -1
-- Dexterity -1
-- Agility -1
-- Vitality -1
-- Intelligence -1
-- Mind -1
-- Sleep Resist 5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5299)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, -1)
    target:addMod(xi.mod.DEX, -1)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.SLEEPRES, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, -1)
    target:delMod(xi.mod.DEX, -1)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.SLEEPRES, 5)
end

return itemObject
