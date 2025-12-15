-----------------------------------
-- ID: 4572
-- Item: serving_of_beaugreen_sautee
-- Food Effect: 180Min, All Races
-----------------------------------
-- Agility 1
-- Vitality -1
-- Ranged Acc % 7
-- Ranged Acc Cap 15
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
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.FOOD_RACCP, 7)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
