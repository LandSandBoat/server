-----------------------------------
-- ID: 5774
-- Item: crepe_forestiere
-- Food Effect: 30Min, All Races
-----------------------------------
-- Mind 2
-- MP % 10 (cap 35)
-- Magic Accuracy +15
-- Magic Def. Bonus +6
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
    effect:addMod(xi.mod.MND, 2)
    effect:addMod(xi.mod.FOOD_MPP, 10)
    effect:addMod(xi.mod.FOOD_MP_CAP, 35)
    effect:addMod(xi.mod.MACC, 15)
    effect:addMod(xi.mod.MDEF, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
