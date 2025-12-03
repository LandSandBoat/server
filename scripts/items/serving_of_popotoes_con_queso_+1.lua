-----------------------------------
-- ID: 6610
-- Item: serving_of_popotoes_con_queso_+1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 6
-- Mind 6
-- Attack % 21
-- Attack Cap 135
-- Ranged Attack % 21
-- Ranged Attack Cap 135
-- Evasion % 11
-- Evasion Cap 55
-- Magic Evasion % 11
-- Magic Evasion Cap 55
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
    effect:addMod(xi.mod.STR, 6)
    effect:addMod(xi.mod.MND, 6)
    effect:addMod(xi.mod.FOOD_ATTP, 21)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 135)
    effect:addMod(xi.mod.FOOD_RATTP, 21)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 135)
    --  effect:addMod(xi.mod.FOOD_EVAP, 11)
    --  effect:addMod(xi.mod.FOOD_EVA_CAP, 55)
    --  effect:addMod(xi.mod.FOOD_MEVAP, 11)
    --  effect:addMod(xi.mod.FOOD_MEVA_CAP, 55)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
