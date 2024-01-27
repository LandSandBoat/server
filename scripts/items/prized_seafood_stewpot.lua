-----------------------------------
-- ID: 5240
-- Item: Prized Seafood Stewpot
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% Cap 100
-- MP +20
-- Dexterity 2
-- Vitality 2
-- Agility 2
-- Mind 2
-- HP Recovered while healing 9
-- MP Recovered while healing 3
-- Accuracy 7
-- Ranged Accuracy 7
-- Evasion 7
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5240)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 100)
    target:addMod(xi.mod.MP, 20)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.MND, 2)
    target:addMod(xi.mod.HPHEAL, 9)
    target:addMod(xi.mod.MPHEAL, 3)
    target:addMod(xi.mod.ACC, 7)
    target:addMod(xi.mod.RACC, 7)
    target:addMod(xi.mod.EVA, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 100)
    target:delMod(xi.mod.MP, 20)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.MND, 2)
    target:delMod(xi.mod.HPHEAL, 9)
    target:delMod(xi.mod.MPHEAL, 3)
    target:delMod(xi.mod.ACC, 7)
    target:delMod(xi.mod.RACC, 7)
    target:delMod(xi.mod.EVA, 7)
end

return itemObject
