-----------------------------------
-- ID: 5178
-- Item: plate_of_dorado_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 5
-- Accuracy % 15
-- Accuracy Cap 72
-- Ranged ACC % 15
-- Ranged ACC Cap 72
-- Sleep Resist 1
-- Enmity 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5178)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ENMITY, 4)
    target:addMod(tpz.mod.DEX, 5)
    target:addMod(tpz.mod.FOOD_ACCP, 15)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 72)
    target:addMod(tpz.mod.FOOD_RACCP, 15)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 72)
    target:addMod(tpz.mod.SLEEPRES, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ENMITY, 4)
    target:delMod(tpz.mod.DEX, 5)
    target:delMod(tpz.mod.FOOD_ACCP, 15)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 72)
    target:delMod(tpz.mod.FOOD_RACCP, 15)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 72)
    target:delMod(tpz.mod.SLEEPRES, 1)
end

return item_object
