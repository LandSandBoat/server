-----------------------------------
-- ID: 5917
-- Item: Choco-scroll
-- Food Effect: 3 Min, All Races
-----------------------------------
-- Mind 1
-- Speed 12.5%
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5917)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MND, 1)
    target:addMod(xi.mod.MOVE_SPEED_QUICKENING, 12)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MND, 1)
    target:delMod(xi.mod.MOVE_SPEED_QUICKENING, 12)
end

return itemObject
