-----------------------------------
-- ID: 4330
-- Item: witch_risotto
-- Food Effect: 4hours, All Races
-----------------------------------
-- Magic Points 35
-- Strength -1
-- Vitality 3
-- Mind 3
-- MP Recovered While Healing 2
-- Enmity -4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_MP, 35)
    effect:addMod(xi.mod.STR, -1)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.MND, 3)
    effect:addMod(xi.mod.MPHEAL, 2)
    effect:addMod(xi.mod.ENMITY, -4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
