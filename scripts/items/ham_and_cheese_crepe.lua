-----------------------------------
-- ID: 5771
-- Item: ham_and_cheese_crepe
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +10% (cap 25)
-- STR +2
-- VIT +1
-- Magic Accuracy +10
-- Magic Defense +3
-- hHP +2
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
    effect:addMod(xi.mod.FOOD_HP_CAP, 25)
    effect:addMod(xi.mod.STR, 2)
    effect:addMod(xi.mod.VIT, 1)
    effect:addMod(xi.mod.MACC, 10)
    effect:addMod(xi.mod.MDEF, 3)
    effect:addMod(xi.mod.HPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
