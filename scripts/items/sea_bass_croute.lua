-----------------------------------
-- ID: 4353
-- Item: sea_bass_croute
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP +5% (cap 150)
-- Dexterity 4
-- Mind 5
-- Accuracy 3
-- Ranged Accuracy % 6 (cap 20)
-- HP recovered while healing 9
-- MP recovered while healing 2
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
    effect:addMod(xi.mod.FOOD_MPP, 5)
    effect:addMod(xi.mod.FOOD_MP_CAP, 150)
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.MND, 5)
    effect:addMod(xi.mod.ACC, 3)
    effect:addMod(xi.mod.FOOD_RACCP, 6)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 20)
    effect:addMod(xi.mod.HPHEAL, 9)
    effect:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
