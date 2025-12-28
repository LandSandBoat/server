-----------------------------------
-- ID: 4324
-- Item: chunk_of_hobgoblin_chocolate
-- Food Effect: 5Min, All Races
-----------------------------------
-- Health Regen While Healing 7
-- Lizard Killer 12
-- Petrify Resist 12
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
    effect:addMod(xi.mod.HPHEAL, 7)
    effect:addMod(xi.mod.LIZARD_KILLER, 12)
    effect:addMod(xi.mod.PETRIFYRES, 12)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
