-----------------------------------
-- ID: 4543
-- Item: goblin_mushpot
-- Food Effect: 180Min, All Races
-----------------------------------
-- Mind 10
-- Charisma -5
-- Poison Resist 4
-- Blind Resist 4
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
    effect:addMod(xi.mod.MND, 10)
    effect:addMod(xi.mod.CHR, -5)
    effect:addMod(xi.mod.POISONRES, 4)
    effect:addMod(xi.mod.BLINDRES, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
