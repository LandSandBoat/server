-----------------------------------
-- ID: 5934
-- Item: Chocobiscuit
-- Food Effect: 3Min, All Races
-----------------------------------
-- Magic Regen While Healing 3
-- Charisma 3
-- Evasion 2
-- Aquan Killer 10
-- Silence Resist 10
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MPHEAL, 3)
    effect:addMod(xi.mod.CHR, 3)
    effect:addMod(xi.mod.EVA, 2)
    effect:addMod(xi.mod.AQUAN_KILLER, 10)
    effect:addMod(xi.mod.SILENCERES, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
