-----------------------------------
-- ID: 5546
-- Item: Prized Crab Stewpot
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% Cap 100
-- MP +20
-- Vitality +2
-- Agility +2
-- Mind +4
-- HP Recovered while healing +9
-- MP Recovered while healing +3
-- Defense 20% Cap 100
-- Evasion +7
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5546)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 100)
    target:addMod(xi.mod.MP, 20)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.MND, 4)
    target:addMod(xi.mod.HPHEAL, 9)
    target:addMod(xi.mod.MPHEAL, 3)
    target:addMod(xi.mod.FOOD_DEFP, 20)
    target:addMod(xi.mod.FOOD_DEF_CAP, 100)
    target:addMod(xi.mod.EVA, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 100)
    target:delMod(xi.mod.MP, 20)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.MND, 4)
    target:delMod(xi.mod.HPHEAL, 9)
    target:delMod(xi.mod.MPHEAL, 3)
    target:delMod(xi.mod.FOOD_DEFP, 20)
    target:delMod(xi.mod.FOOD_DEF_CAP, 100)
    target:delMod(xi.mod.EVA, 7)
end

return itemObject
