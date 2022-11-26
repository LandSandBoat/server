-----------------------------------
-- ID: 5545
-- Item: Prime Crab Stewpot
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% Cap 75
-- MP +15
-- Vitality +1
-- Agility +1
-- Mind +2
-- HP Recovered while healing +7
-- MP Recovered while healing +2
-- Defense 20% Cap 75
-- Evasion +6
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5545)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 75)
    target:addMod(xi.mod.MP, 15)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.MND, 2)
    target:addMod(xi.mod.HPHEAL, 7)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.FOOD_DEFP, 20)
    target:addMod(xi.mod.FOOD_DEF_CAP, 75)
    target:addMod(xi.mod.EVA, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 75)
    target:delMod(xi.mod.MP, 15)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.MND, 2)
    target:delMod(xi.mod.HPHEAL, 7)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.FOOD_DEFP, 20)
    target:delMod(xi.mod.FOOD_DEF_CAP, 75)
    target:delMod(xi.mod.EVA, 6)
end

return itemObject
