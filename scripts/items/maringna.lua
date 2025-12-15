-----------------------------------
-- ID: 5888
-- Item: maringna
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +9% (cap 160)
-- Increases rate of combat skill gains by 80%
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
    effect:addMod(xi.mod.FOOD_HPP, 9)
    effect:addMod(xi.mod.FOOD_HP_CAP, 160)
    effect:addMod(xi.mod.COMBAT_SKILLUP_RATE, 80)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
