-----------------------------------
--  ID: 5682
--  Item: Purple Polypore
--  Food Effect: 5 Min, All Races
-----------------------------------
--  Strength -6
--  Mind +4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5682)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, -6)
    target:addMod(xi.mod.MND, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, -6)
    target:delMod(xi.mod.MND, 4)
end

return itemObject
