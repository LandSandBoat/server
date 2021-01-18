-----------------------------------
-- ID: 5671
-- Item: Bowl of Loach Soup
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- Dexterity 4
-- Agility 4
-- Accuracy 7% Cap 50
-- Ranged Accuracy 7% Cap 50
-- HP 7% Cap 50
-- Evasion 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5671)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.FOOD_ACCP, 7)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 50)
    target:addMod(tpz.mod.FOOD_RACCP, 7)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 50)
    target:addMod(tpz.mod.FOOD_HPP, 7)
    target:addMod(tpz.mod.FOOD_HP_CAP, 50)
    target:addMod(tpz.mod.EVA, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.FOOD_ACCP, 7)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 50)
    target:delMod(tpz.mod.FOOD_RACCP, 7)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 50)
    target:delMod(tpz.mod.FOOD_HPP, 7)
    target:delMod(tpz.mod.FOOD_HP_CAP, 50)
    target:delMod(tpz.mod.EVA, 5)
end

return item_object
