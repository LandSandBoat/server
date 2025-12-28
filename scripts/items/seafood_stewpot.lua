-----------------------------------
-- ID: 5238
-- Item: Seafood Stewpot
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% Cap 50
-- MP +10
-- Accuracy 5
-- Ranged Accuracy 5
-- Evasion 5
-- hHP 5
-- hMP 1
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
    effect:addMod(xi.mod.FOOD_HP_CAP, 50)
    effect:addMod(xi.mod.FOOD_MP, 10)
    effect:addMod(xi.mod.ACC, 5)
    effect:addMod(xi.mod.RACC, 5)
    effect:addMod(xi.mod.EVA, 5)
    effect:addMod(xi.mod.HPHEAL, 5)
    effect:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
