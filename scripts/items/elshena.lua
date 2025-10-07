-----------------------------------
-- ID: 5886
-- Item: elshena
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +7% (cap 120)
-- Increases rate of combat skill gains by 40%
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 7)
    target:addMod(xi.mod.FOOD_HP_CAP, 120)
    target:addMod(xi.mod.COMBAT_SKILLUP_RATE, 40)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 7)
    target:delMod(xi.mod.FOOD_HP_CAP, 120)
    target:delMod(xi.mod.COMBAT_SKILLUP_RATE, 40)
end

return itemObject
