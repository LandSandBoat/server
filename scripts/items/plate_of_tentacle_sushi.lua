-----------------------------------
-- ID: 5215
-- Item: plate_of_tentacle_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP 20
-- Dexterity 3
-- Agility 3
-- Mind -1
-- Accuracy % 20 (cap 18)
-- Ranged Accuracy % 20 (cap 18)
-- Double Attack 1
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
    effect:addMod(xi.mod.FOOD_HP, 20)
    effect:addMod(xi.mod.DEX, 3)
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.MND, -1)
    effect:addMod(xi.mod.FOOD_ACCP, 20)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 18)
    effect:addMod(xi.mod.FOOD_RACCP, 20)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 18)
    effect:addMod(xi.mod.DOUBLE_ATTACK, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
