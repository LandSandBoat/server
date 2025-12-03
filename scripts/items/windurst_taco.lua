-----------------------------------
-- ID: 5172
-- Item: windurst_taco
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP 20
-- Vitality -1
-- Agility 5
-- MP Recovered While Healing 1
-- Ranged Accuracy % 8 (cap 10)
-- Ranged Attack +1
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
    effect:addMod(xi.mod.FOOD_MP, 20)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.AGI, 5)
    effect:addMod(xi.mod.MPHEAL, 1)
    effect:addMod(xi.mod.RATT, 1)
    effect:addMod(xi.mod.FOOD_RACCP, 8)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
