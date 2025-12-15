-----------------------------------
-- ID: 5968
-- Item: Plate of Seafood Paella
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- HP 40
-- Dexterity 5
-- Mind -1
-- Accuracy % 15 (cap 80)
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
    effect:addMod(xi.mod.DEX, 5)
    effect:addMod(xi.mod.MND, -1)
    effect:addMod(xi.mod.FOOD_ACCP, 15)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 80)
    effect:addMod(xi.mod.UNDEAD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
