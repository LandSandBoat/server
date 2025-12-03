-----------------------------------
-- ID: 4563
-- Item: pamama_tart
-- Food Effect: 1hour, All Races
-----------------------------------
-- HP 10
-- MP 10
-- Dexterity -1
-- Intelligence 3
-- MP Recovered While Healing 2
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
    effect:addMod(xi.mod.FOOD_HP, 10)
    effect:addMod(xi.mod.FOOD_MP, 10)
    effect:addMod(xi.mod.DEX, -1)
    effect:addMod(xi.mod.INT, 3)
    effect:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
