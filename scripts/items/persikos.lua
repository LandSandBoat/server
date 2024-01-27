-----------------------------------
-- ID: 4274
-- Item: persikos
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility -7
-- Intelligence 5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4274)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, -7)
    target:addMod(xi.mod.INT, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, -7)
    target:delMod(xi.mod.INT, 5)
end

return itemObject
