-----------------------------------
-- ID: 5778
-- Item: Crepe Belle Helene
-- Food Effect: 60 Min, All Races
-----------------------------------
-- Intelligence +2
-- MP Healing +3
-- Magic Accuracy +21% (cap 50)
-- Magic Defense +1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.INT, 2)
    effect:addMod(xi.mod.MPHEAL, 3)
    effect:addMod(xi.mod.FOOD_MACCP, 21)
    effect:addMod(xi.mod.FOOD_MACC_CAP, 50)
    effect:addMod(xi.mod.MDEF, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
