-----------------------------------
-- ID: 4457
-- Item: eel_kabob
-- Food Effect: 30Min, All Races
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.MND, -3)
    effect:addMod(xi.mod.EVA, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
