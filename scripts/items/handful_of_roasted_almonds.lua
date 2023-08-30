-----------------------------------
-- ID: 5649
-- Item: Handful of Roasted Almonds
-- Food Effect: 5Min, All Races
-----------------------------------
-- HP 30
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5649)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
end

return itemObject
