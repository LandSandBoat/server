-----------------------------------
-- ID: 4488
-- Item: jack-o-lantern
-- Food Effect: 180Min, All Races
-----------------------------------
-- Charisma -10
-- Accuracy 10
-- Ranged Acc 10
-- Evasion 10
-- Arcana Killer 4
-- Dark Res 25
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.CHR, -10)
    effect:addMod(xi.mod.ACC, 10)
    effect:addMod(xi.mod.RACC, 10)
    effect:addMod(xi.mod.EVA, 10)
    effect:addMod(xi.mod.ARCANA_KILLER, 4)
    effect:addMod(xi.mod.DARK_MEVA, 25)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
