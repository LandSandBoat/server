-----------------------------------------
-- ID: 6277
-- Item: deep-fried_shrimp
-- Food Effect: 60Min, All Races
-----------------------------------------
-- VIT +4
-- Fire resistance +21
-- Accuracy +21% (cap 75)
-- Ranged Accuracy +21% (cap 75)
-- Subtle Blow +9
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6277)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.FIRERES, 21)
    target:addMod(tpz.mod.FOOD_ACCP, 21)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 75)
    target:addMod(tpz.mod.FOOD_RACCP, 21)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 75)
    target:addMod(tpz.mod.SUBTLE_BLOW, 9)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.FIRERES, 21)
    target:delMod(tpz.mod.FOOD_ACCP, 21)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 75)
    target:delMod(tpz.mod.FOOD_RACCP, 21)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 75)
    target:delMod(tpz.mod.SUBTLE_BLOW, 9)
end

return item_object
