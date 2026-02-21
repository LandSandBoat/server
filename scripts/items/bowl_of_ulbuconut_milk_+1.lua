-----------------------------------
-- ID: 5977
-- Item: Bowl of Ulbuconut Milk +1
-- Food Effect: 3Min, All Races
-----------------------------------
-- Charisma +4
-- Vitality -1
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
    effect:addMod(xi.mod.CHR, 4)
    effect:addMod(xi.mod.VIT, -1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
