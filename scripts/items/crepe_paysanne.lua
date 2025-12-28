-----------------------------------
-- ID: 5772
-- Item: crepe_paysanne
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +10% (cap 30)
-- STR +2
-- VIT +1
-- Magic Accuracy +15
-- Magic Defense +4
-- hHP +3
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
    effect:addMod(xi.mod.FOOD_HP_CAP, 30)
    effect:addMod(xi.mod.STR, 2)
    effect:addMod(xi.mod.VIT, 1)
    effect:addMod(xi.mod.MACC, 15)
    effect:addMod(xi.mod.MDEF, 4)
    effect:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
