-----------------------------------
-- ID: 6612
-- Item: serving_of_seafood_gratin_+1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 8
-- Mind 8
-- Accuracy % 21
-- Accuracy Cap 75
-- Ranged Accuracy % 21
-- Ranged Accuracy Cap 75
-- Evasion % 13
-- Evasion Cap 65
-- Magic Evasion % 13
-- Magic Evasion Cap 65
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
    effect:addMod(xi.mod.DEX, 8)
    effect:addMod(xi.mod.MND, 8)
    effect:addMod(xi.mod.FOOD_ACCP, 21)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 75)
    effect:addMod(xi.mod.FOOD_RACCP, 21)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 75)
    --  effect:addMod(xi.mod.FOOD_EVAP, 13)
    --  effect:addMod(xi.mod.FOOD_EVA_CAP, 65)
    --  effect:addMod(xi.mod.FOOD_MEVAP, 13)
    --  effect:addMod(xi.mod.FOOD_MEVA_CAP, 65)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
