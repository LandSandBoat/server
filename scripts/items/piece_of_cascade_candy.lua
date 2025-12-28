-----------------------------------
-- ID: 5942
-- Item: Piece of Cascade Candy
-- Food Effect: 30Min, All Races
-----------------------------------
-- Mind +4
-- Charisma +4
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
    effect:addMod(xi.mod.MND, 4)
    effect:addMod(xi.mod.CHR, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
