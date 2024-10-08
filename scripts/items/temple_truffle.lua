-----------------------------------
-- ID: 5916
-- Item: Temple Truffle
-- Food Effect: 3 Min, All Races
-----------------------------------
-- Strength 1
-- Base speed 10% or +5
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5916)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 1)
    target:addMod(xi.mod.MOVE_SPEED_QUICKENING, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 1)
    target:delMod(xi.mod.MOVE_SPEED_QUICKENING, 5)
end

return itemObject
