-----------------------------------
-- ID: 5727
-- Item: serving_of_zaru_soba
-- Food Effect: 30Min?, All Races
-----------------------------------
-- Agility 3
-- HP % 12 (cap 180)
-- Resist Sleep +5
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
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.FOOD_HPP, 12)
    effect:addMod(xi.mod.FOOD_HP_CAP, 180)
    effect:addMod(xi.mod.SLEEPRES, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
