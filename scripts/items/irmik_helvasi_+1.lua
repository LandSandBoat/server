-----------------------------------
-- ID: 5573
-- Item: irmik_helvasi_+1
-- Food Effect: 4 hours, All Races
-----------------------------------
-- HP +10% (cap 100)
-- MP +3% (cap 15)
-- INT +2
-- hHP +1
-- hMP +1
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
    effect:addMod(xi.mod.FOOD_HPP, 10)
    effect:addMod(xi.mod.FOOD_HP_CAP, 100)
    effect:addMod(xi.mod.FOOD_MPP, 3)
    effect:addMod(xi.mod.FOOD_MP_CAP, 15)
    effect:addMod(xi.mod.INT, 2)
    effect:addMod(xi.mod.HPHEAL, 1)
    effect:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
