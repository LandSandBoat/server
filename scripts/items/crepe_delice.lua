-----------------------------------
-- ID: 5767
-- Item: Crepe Delice
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +10% (cap 15)
-- Magic Accuracy +21% (cap 30)
-- Magic Defense +2
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
    effect:addMod(xi.mod.FOOD_HPP, 10)
    effect:addMod(xi.mod.FOOD_HP_CAP, 15)
    effect:addMod(xi.mod.MDEF, 2)
    effect:addMod(xi.mod.FOOD_MACCP, 21)
    effect:addMod(xi.mod.FOOD_MACC_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
