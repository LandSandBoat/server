-----------------------------------
-- ID: 5666
-- Item: plate_of_fin_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Intelligence 6
-- Accuracy % 17 (cap 80)
-- Ranged Accuracy % 17 (cap 80)
-- Resist Sleep +2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5666)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.INT, 6)
    target:addMod(tpz.mod.FOOD_ACCP, 17)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 80)
    target:addMod(tpz.mod.FOOD_RACCP, 17)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 80)
    target:addMod(tpz.mod.SLEEPRES, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.INT, 6)
    target:delMod(tpz.mod.FOOD_ACCP, 17)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 80)
    target:delMod(tpz.mod.FOOD_RACCP, 17)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 80)
    target:delMod(tpz.mod.SLEEPRES, 2)
end

return item_object
