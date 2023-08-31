-----------------------------------
-- ID: 5143
-- Item: serving_of_goblin_stir-fry
-- Food Effect: 180Min, All Races
-----------------------------------
-- Agility 5
-- Vitality 2
-- Charisma -5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5143)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 5)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.CHR, -5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 5)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.CHR, -5)
end

return itemObject
