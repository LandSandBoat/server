-----------------------------------------
-- ID: 6467
-- Item: bowl_of_miso_soup_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- HP +8% (cap 55)
-- DEX +5
-- AGI +5
-- Accuracy +11% (cap 45)
-- Attack +11% (cap 45)
-- Ranged Accuracy +11% (cap 45)
-- Ranged Attack +11% (cap 45)
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6467)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 8)
    target:addMod(tpz.mod.FOOD_HP_CAP, 55)
    target:addMod(tpz.mod.DEX, 5)
    target:addMod(tpz.mod.AGI, 5)
    target:addMod(tpz.mod.FOOD_ACCP, 11)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 45)
    target:addMod(tpz.mod.FOOD_RACCP, 11)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 45)
    target:addMod(tpz.mod.FOOD_ATTP, 11)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 45)
    target:addMod(tpz.mod.FOOD_RATTP, 11)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 45)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 8)
    target:delMod(tpz.mod.FOOD_HP_CAP, 55)
    target:delMod(tpz.mod.DEX, 5)
    target:delMod(tpz.mod.AGI, 5)
    target:delMod(tpz.mod.FOOD_ACCP, 11)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 45)
    target:delMod(tpz.mod.FOOD_RACCP, 11)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 45)
    target:delMod(tpz.mod.FOOD_ATTP, 11)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 45)
    target:delMod(tpz.mod.FOOD_RATTP, 11)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 45)
end

return item_object
