-----------------------------------
-- ID: 5611
-- Item: Angler's Stewpot
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% (cap 200)
-- MP +10
-- HP Recoverd while healing 5
-- MP Recovered while healing 1
-- Accuracy +15% Cap 15
-- Ranged Accuracy 15% Cap 15
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
    effect:addMod(xi.mod.FOOD_HPP, 10)
    effect:addMod(xi.mod.FOOD_HP_CAP, 200)
    effect:addMod(xi.mod.FOOD_MP, 10)
    effect:addMod(xi.mod.HPHEAL, 5)
    effect:addMod(xi.mod.MPHEAL, 1)
    effect:addMod(xi.mod.FOOD_ACCP, 15)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 15)
    effect:addMod(xi.mod.FOOD_RACCP, 15)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
