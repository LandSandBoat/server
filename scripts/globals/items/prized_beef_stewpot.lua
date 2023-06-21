-----------------------------------
-- ID: 5549
-- Item: Prized Angler's Stewpot
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% Cap 100
-- MP +20
-- Strength +4
-- Agility +2
-- Mind +2
-- HP Recovered while healing +9
-- MP Recovered while healing +3
-- Attack 18% Cap 80
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5549)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 100)
    target:addMod(xi.mod.MP, 20)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.MND, 2)
    target:addMod(xi.mod.HPHEAL, 9)
    target:addMod(xi.mod.MPHEAL, 3)
    target:addMod(xi.mod.FOOD_ATTP, 18)
    target:addMod(xi.mod.FOOD_ATT_CAP, 80)
    target:addMod(xi.mod.EVA, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 100)
    target:delMod(xi.mod.MP, 20)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.MND, 2)
    target:delMod(xi.mod.HPHEAL, 9)
    target:delMod(xi.mod.MPHEAL, 3)
    target:delMod(xi.mod.FOOD_ATTP, 18)
    target:delMod(xi.mod.FOOD_ATT_CAP, 80)
    target:delMod(xi.mod.EVA, 7)
end

return itemObject
