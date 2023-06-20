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
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5238)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 50)
    target:addMod(xi.mod.MP, 10)
    target:addMod(xi.mod.ACC, 5)
    target:addMod(xi.mod.RACC, 5)
    target:addMod(xi.mod.EVA, 5)
    target:addMod(xi.mod.HPHEAL, 5)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 50)
    target:delMod(xi.mod.MP, 10)
    target:delMod(xi.mod.ACC, 5)
    target:delMod(xi.mod.RACC, 5)
    target:delMod(xi.mod.EVA, 5)
    target:delMod(xi.mod.HPHEAL, 5)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
