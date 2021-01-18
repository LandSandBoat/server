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
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5239)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 10)
    target:addMod(tpz.mod.FOOD_HP_CAP, 75)
    target:addMod(tpz.mod.MP, 15)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.MND, 1)
    target:addMod(tpz.mod.HPHEAL, 7)
    target:addMod(tpz.mod.MPHEAL, 2)
    target:addMod(tpz.mod.ACC, 6)
    target:addMod(tpz.mod.RACC, 6)
    target:addMod(tpz.mod.EVA, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 10)
    target:delMod(tpz.mod.FOOD_HP_CAP, 75)
    target:delMod(tpz.mod.MP, 15)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.MND, 1)
    target:delMod(tpz.mod.HPHEAL, 7)
    target:delMod(tpz.mod.MPHEAL, 2)
    target:delMod(tpz.mod.ACC, 6)
    target:delMod(tpz.mod.RACC, 6)
    target:delMod(tpz.mod.EVA, 6)
end

return item_object
