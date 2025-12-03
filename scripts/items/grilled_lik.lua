-----------------------------------
-- ID: 5648
-- Item: Grilled Lik
-- Food Effect: 60 Mins, All Races
-----------------------------------
-- Dexterity 4
-- Mind -3
-- Accuracy +2
-- Attack +8
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
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.MND, -3)
    effect:addMod(xi.mod.ACC, 2)
    effect:addMod(xi.mod.ATT, 8)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
