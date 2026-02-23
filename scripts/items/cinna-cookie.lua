-----------------------------------
-- ID: 4397
-- Item: cinna-cookie
-- Food Effect: 3Min, All Races
-----------------------------------
-- Magic Regen While Healing 4
-- Vermin Killer 10
-- Poison Resist 10
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 180, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MPHEAL, 4)
    effect:addMod(xi.mod.VERMIN_KILLER, 10)
    effect:addMod(xi.mod.POISONRES, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
