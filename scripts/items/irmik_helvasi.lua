-----------------------------------
-- ID: 5572
-- Item: irmik_helvasi
-- Food Effect: 3 hours, All Races
-----------------------------------
-- HP +10% (cap 75)
-- MP +3% (cap 13)
-- INT +1
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
    effect:addMod(xi.mod.FOOD_HPP, 10)
    effect:addMod(xi.mod.FOOD_HP_CAP, 75)
    effect:addMod(xi.mod.FOOD_MPP, 3)
    effect:addMod(xi.mod.FOOD_MP_CAP, 13)
    effect:addMod(xi.mod.INT, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
