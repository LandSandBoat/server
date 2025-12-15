-----------------------------------
-- ID: 5643
-- Item: serving_of_cibarious_cilbir
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP % 6 (cap 150)
-- MP % 6 (cap 100)
-- HP recovered while healing 3
-- MP recovered while healing 4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HPP, 6)
    effect:addMod(xi.mod.FOOD_HP_CAP, 150)
    effect:addMod(xi.mod.FOOD_MPP, 6)
    effect:addMod(xi.mod.FOOD_MP_CAP, 100)
    effect:addMod(xi.mod.MPHEAL, 4)
    effect:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
