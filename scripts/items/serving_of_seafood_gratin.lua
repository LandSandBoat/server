-----------------------------------
-- ID: 6611
-- Item: serving_of_seafood_gratin
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 7
-- Mind 7
-- Accuracy % 20
-- Accuracy Cap 70
-- Ranged Accuracy % 20
-- Ranged Accuracy Cap 70
-- Evasion % 12
-- Evasion Cap 60
-- Magic Evasion % 12
-- Magic Evasion Cap 60
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
    effect:addMod(xi.mod.DEX, 7)
    effect:addMod(xi.mod.MND, 7)
    effect:addMod(xi.mod.FOOD_ACCP, 20)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 70)
    effect:addMod(xi.mod.FOOD_RACCP, 20)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 70)
    --  effect:addMod(xi.mod.FOOD_EVAP, 12)
    --  effect:addMod(xi.mod.FOOD_EVA_CAP, 60)
    --  effect:addMod(xi.mod.FOOD_MEVAP, 12)
    --  effect:addMod(xi.mod.FOOD_MEVA_CAP, 60)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
