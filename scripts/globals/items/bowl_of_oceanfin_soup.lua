-----------------------------------
-- ID: 6070
-- Item: Bowl of Oceanfin Soup
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- Accuracy % 15 Cap 95
-- Ranged Accuracy % 15 Cap 95
-- Attack % 19 Cap 85
-- Ranged Attack % 19 Cap 85
-- Amorph Killer 6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 6070)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_ACCP, 15)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 95)
    target:addMod(tpz.mod.FOOD_RACCP, 15)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 95)
    target:addMod(tpz.mod.FOOD_ATTP, 19)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 85)
    target:addMod(tpz.mod.FOOD_RATTP, 19)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 85)
    target:addMod(tpz.mod.AMORPH_KILLER, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_ACCP, 15)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 95)
    target:delMod(tpz.mod.FOOD_RACCP, 15)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 95)
    target:delMod(tpz.mod.FOOD_ATTP, 19)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 85)
    target:delMod(tpz.mod.FOOD_RATTP, 19)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 85)
    target:delMod(tpz.mod.AMORPH_KILLER, 6)
end

return item_object
