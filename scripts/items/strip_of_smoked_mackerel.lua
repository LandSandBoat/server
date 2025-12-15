-----------------------------------
-- ID: 5943
-- Item: Strip of Smoked Mackerel
-- Food Effect: 30Min, All Races
-----------------------------------
-- Agility 4
-- Vitality -3
-- Evasion +5
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
    effect:addMod(xi.mod.AGI, 4)
    effect:addMod(xi.mod.VIT, -3)
    effect:addMod(xi.mod.EVA, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
