-----------------------------------
-- ID: 5775
-- Item: Chocolate Crepe
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +5% (cap 15)
-- MP Healing 2
-- Magic Accuracy +20% (cap 35)
-- Magic Defense +1
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
    effect:addMod(xi.mod.FOOD_HP_CAP, 15)
    effect:addMod(xi.mod.MPHEAL, 2)
    effect:addMod(xi.mod.MDEF, 1)
    effect:addMod(xi.mod.FOOD_MACCP, 20)
    effect:addMod(xi.mod.FOOD_MACC_CAP, 35)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
