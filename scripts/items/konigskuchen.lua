-----------------------------------
-- ID: 5614
-- Item: konigskuchen
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 8
-- Magic % 3
-- Magic Cap 13
-- Intelligence 2
-- hMP +1
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
    effect:addMod(xi.mod.FOOD_HP, 8)
    effect:addMod(xi.mod.FOOD_MPP, 3)
    effect:addMod(xi.mod.FOOD_MP_CAP, 13)
    effect:addMod(xi.mod.INT, 2)
    effect:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
