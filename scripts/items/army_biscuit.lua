-----------------------------------
-- ID: 5657
-- Item: army_biscuit
-- Food Effect: 5Min?, All Races
-----------------------------------
-- HP Recovered While Healing 3
-- MP Recovered While Healing 3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.HPHEAL, 3)
    effect:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
