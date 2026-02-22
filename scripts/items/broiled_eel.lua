-----------------------------------
-- ID: 4588
-- Item: Broiled Eel
-- Food Effect: 60Min, All Races
-----------------------------------
-- Dexterity 4
-- Mind -3
-- Evasion 5
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 3600, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.MND, -3)
    effect:addMod(xi.mod.EVA, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
