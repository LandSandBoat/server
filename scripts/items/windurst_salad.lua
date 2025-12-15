-----------------------------------
-- ID: 4555
-- Item: windurst_salad
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic 20
-- Agility 5
-- Vitality -1
-- Ranged ACC % 8
-- Ranged ACC Cap 10
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
    effect:addMod(xi.mod.FOOD_MP, 20)
    effect:addMod(xi.mod.AGI, 5)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.FOOD_RACCP, 8)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
