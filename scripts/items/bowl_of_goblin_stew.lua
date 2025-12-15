-----------------------------------
-- ID: 4465
-- Item: bowl_of_goblin_stew
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Dexterity -4
-- Attack +16% (cap 80)
-- Ranged Attack +16% (cap 80)
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
    effect:addMod(xi.mod.DEX, -4)
    effect:addMod(xi.mod.FOOD_ATTP, 16)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 80)
    effect:addMod(xi.mod.FOOD_RATTP, 16)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 80)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
