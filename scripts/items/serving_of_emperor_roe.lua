-----------------------------------
-- ID: 4275
-- Item: serving_of_emperor_roe
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 8
-- Magic 8
-- Dexterity 4
-- Mind -4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4275)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 8)
    target:addMod(xi.mod.MP, 8)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.MND, -4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 8)
    target:delMod(xi.mod.MP, 8)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.MND, -4)
end

return itemObject
