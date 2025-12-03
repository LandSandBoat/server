-----------------------------------
-- ID: 6576
-- Item: rolanberry_turkey
-- Food Effect: 4 Hours, All Races
-----------------------------------
-- STR +10
-- Attack +20% (Max. 120)
-- Ranged Attack +20% (Max. 120)
-- "Counter" +10
-- "Resist Amnesia" +10
-- https://www.bg-wiki.com/ffxi/Rol._Turkey
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
    effect:addMod(xi.mod.STR, 10)
    effect:addMod(xi.mod.FOOD_ATTP, 20)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 120)
    effect:addMod(xi.mod.FOOD_RATTP, 20)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 120)
    effect:addMod(xi.mod.COUNTER, 10)
    effect:addMod(xi.mod.AMNESIARES, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
