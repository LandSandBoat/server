-----------------------------------
-- ID: 5776
-- Item: Crepe Caprice
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +5% (cap20)
-- MP Healing 3
-- Magic Accuracy +21% (cap 40)
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
    effect:addMod(xi.mod.FOOD_HPP, 5)
    effect:addMod(xi.mod.FOOD_HP_CAP, 20)
    effect:addMod(xi.mod.MPHEAL, 3)
    effect:addMod(xi.mod.MDEF, 2)
    effect:addMod(xi.mod.FOOD_MACCP, 21)
    effect:addMod(xi.mod.FOOD_MACC_CAP, 40)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
