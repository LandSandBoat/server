-----------------------------------
-- ID: 5170
-- Item: green_quiche
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 10
-- Agility 1
-- Vitality -1
-- Ranged ACC % 7
-- Ranged ACC Cap 15
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
    effect:addMod(xi.mod.FOOD_MP, 10)
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.FOOD_RACCP, 7)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
