-----------------------------------
-- ID: 5970
-- Item: Plate of Mushroom Paella
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- HP 40
-- Strength -1
-- Mind 5
-- Magic Accuracy 5
-- Undead Killer 5
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
    effect:addMod(xi.mod.FOOD_HP, 40)
    effect:addMod(xi.mod.STR, -1)
    effect:addMod(xi.mod.MND, 5)
    effect:addMod(xi.mod.MACC, 5)
    effect:addMod(xi.mod.UNDEAD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
