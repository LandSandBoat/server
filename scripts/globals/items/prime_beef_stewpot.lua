-----------------------------------
-- ID: 5548
-- Item: Prime Beef Stewpot
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% Cap 75
-- MP +15
-- Strength +2
-- Agility +1
-- Mind +1
-- HP Recovered while healing +7
-- MP Recovered while healing +2
-- Attack 18% Cap 60
-- Evasion +6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5548)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 75)
    target:addMod(xi.mod.MP, 15)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.MND, 1)
    target:addMod(xi.mod.HPHEAL, 7)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.FOOD_ATTP, 18)
    target:addMod(xi.mod.FOOD_ATT_CAP, 60)
    target:addMod(xi.mod.EVA, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 75)
    target:delMod(xi.mod.MP, 15)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.MND, 1)
    target:delMod(xi.mod.HPHEAL, 7)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.FOOD_ATTP, 18)
    target:delMod(xi.mod.FOOD_ATT_CAP, 60)
    target:delMod(xi.mod.EVA, 6)
end

return itemObject
