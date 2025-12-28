-----------------------------------
-- ID: 4290
-- Item: elshimo_frog
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Dexterity 2
-- Agility 2
-- Mind -4
-- Evasion 5
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_FISH)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, 2)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.MND, -4)
    effect:addMod(xi.mod.EVA, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
