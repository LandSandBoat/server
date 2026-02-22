-----------------------------------
-- ID: 4344
-- Item: witch_stew
-- Food Effect: 4hours, All Races
-----------------------------------
-- Magic Points 45
-- Strength -1
-- Mind 4
-- MP Recovered While Healing 4
-- Enmity -4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 14400, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_MP, 45)
    effect:addMod(xi.mod.STR, -1)
    effect:addMod(xi.mod.MND, 4)
    effect:addMod(xi.mod.MPHEAL, 4)
    effect:addMod(xi.mod.ENMITY, -4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
