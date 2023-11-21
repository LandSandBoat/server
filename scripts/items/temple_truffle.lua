-----------------------------------
-- ID: 5916
-- Item: Temple Truffle
-- Food Effect: 3 Min, All Races
-----------------------------------
-- Strength 1
-- Speed 12.5%
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5916)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 1)
    target:addMod(xi.mod.MOVE_SPEED_QUICKENING, 12)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 1)
    target:delMod(xi.mod.MOVE_SPEED_QUICKENING, 12)
end

return itemObject
