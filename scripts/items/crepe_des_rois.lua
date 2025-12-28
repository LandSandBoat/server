-----------------------------------
-- ID: 6568
-- Item: Crepe des Rois
-- Food Effect: 30 minutes, all Races
-----------------------------------
-- INT +2
-- MND +2
-- Magic Accuracy +21% (Max. 95)
-- "Magic Def. Bonus" +1
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
    effect:addMod(xi.mod.INT, 2)
    effect:addMod(xi.mod.MND, 2)
    effect:addMod(xi.mod.FOOD_MACCP, 21)
    effect:addMod(xi.mod.FOOD_MACC_CAP, 95)
    effect:addMod(xi.mod.MDEF, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
