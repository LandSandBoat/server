-----------------------------------
-- ID: 5239
-- Item: Prime Seafood Stewpot
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% Cap 75
-- MP +15
-- Dexterity 1
-- Vitality 1
-- Agility 1
-- Mind 1
-- HP Recovered while healing 7
-- MP Recovered while healing 2
-- Accuracy 6
-- Ranged Accuracy 6
-- Evasion 6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5239)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 75)
    target:addMod(xi.mod.MP, 15)
    target:addMod(xi.mod.DEX, 1)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.MND, 1)
    target:addMod(xi.mod.HPHEAL, 7)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.ACC, 6)
    target:addMod(xi.mod.RACC, 6)
    target:addMod(xi.mod.EVA, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 75)
    target:delMod(xi.mod.MP, 15)
    target:delMod(xi.mod.DEX, 1)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.MND, 1)
    target:delMod(xi.mod.HPHEAL, 7)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.ACC, 6)
    target:delMod(xi.mod.RACC, 6)
    target:delMod(xi.mod.EVA, 6)
end

return itemObject
