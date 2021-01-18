-----------------------------------
-- ID: 5691
-- Item: plate_of_shrimp_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Vitality 1
-- Defense 5
-- Accuracy % 14 (cap 68)
-- Ranged Accuracy % 14 (cap 68)
-- Resist sleep +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5691)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.DEF, 5)
    target:addMod(tpz.mod.FOOD_ACCP, 14)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 68)
    target:addMod(tpz.mod.FOOD_RACCP, 14)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 68)
    target:addMod(tpz.mod.SLEEPRES, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.DEF, 5)
    target:delMod(tpz.mod.FOOD_ACCP, 14)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 68)
    target:delMod(tpz.mod.FOOD_RACCP, 14)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 68)
    target:delMod(tpz.mod.SLEEPRES, 1)
end

return item_object
