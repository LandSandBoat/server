-----------------------------------
-- ID: 5616
-- Item: lebkuchen_house
-- Food Effect: 180Min, All Races
-----------------------------------
-- HP +8
-- MP +10% (cap 45)
-- INT +3
-- hHP +2
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
    effect:addMod(xi.mod.FOOD_MPP, 10)
    effect:addMod(xi.mod.FOOD_MP_CAP, 45)
    effect:addMod(xi.mod.INT, 3)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
