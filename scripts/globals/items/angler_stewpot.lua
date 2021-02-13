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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5611)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 10)
    target:addMod(tpz.mod.FOOD_HP_CAP, 200)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.HPHEAL, 5)
    target:addMod(tpz.mod.MPHEAL, 1)
    target:addMod(tpz.mod.FOOD_ACCP, 15)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 15)
    target:addMod(tpz.mod.FOOD_RACCP, 15)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 10)
    target:delMod(tpz.mod.FOOD_HP_CAP, 200)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.HPHEAL, 5)
    target:delMod(tpz.mod.MPHEAL, 1)
    target:delMod(tpz.mod.FOOD_ACCP, 15)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 15)
    target:delMod(tpz.mod.FOOD_RACCP, 15)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 15)
end

return item_object
