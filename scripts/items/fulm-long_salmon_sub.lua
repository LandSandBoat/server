-----------------------------------
-- ID: 4266
-- Item: fulm-long_salmon_sub
-- Food Effect: 60Min, All Races
-----------------------------------
-- DEX +2
-- VIT +1
-- AGI +1
-- INT +2
-- MND -2
-- Ranged Accuracy +3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, 2)
    effect:addMod(xi.mod.VIT, 1)
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.INT, 2)
    effect:addMod(xi.mod.MND, -2)
    effect:addMod(xi.mod.RACC, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
