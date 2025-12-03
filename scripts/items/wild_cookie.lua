-----------------------------------
-- ID: 4577
-- Item: wild_cookie
-- Food Effect: 5Min, All Races
-----------------------------------
-- Aquan killer +12
-- Silence resistance +12
-- MP recovered while healing +5
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
    effect:addMod(xi.mod.AQUAN_KILLER, 12)
    effect:addMod(xi.mod.SILENCERES, 12)
    effect:addMod(xi.mod.MPHEAL, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
