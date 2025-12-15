-----------------------------------
-- ID: 4551
-- Item: salmon_croute
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP +3% (cap 130)
-- Dexterity 2
-- MND -2
-- Ranged Accuracy +6% (cap 15)
-- HP recovered while healing 2
-- MP recovered while healing 1
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
    effect:addMod(xi.mod.FOOD_MPP, 3)
    effect:addMod(xi.mod.FOOD_MP_CAP, 130)
    effect:addMod(xi.mod.DEX, 2)
    effect:addMod(xi.mod.MND, -2)
    effect:addMod(xi.mod.FOOD_RACCP, 6)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 15)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
