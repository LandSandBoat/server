-----------------------------------
-- ID: 5160
-- Item: plate_of_urchin_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 40
-- Strength 1
-- Vitality 6
-- Accuracy % 16 (cap 76)
-- Ranged ACC % 16 (cap 76)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5160)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 40)
    target:addMod(tpz.mod.STR, 1)
    target:addMod(tpz.mod.VIT, 6)
    target:addMod(tpz.mod.FOOD_ACCP, 16)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 76)
    target:addMod(tpz.mod.FOOD_RACCP, 16)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 76)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 40)
    target:delMod(tpz.mod.STR, 1)
    target:delMod(tpz.mod.VIT, 6)
    target:delMod(tpz.mod.FOOD_ACCP, 16)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 76)
    target:delMod(tpz.mod.FOOD_RACCP, 16)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 76)
end

return item_object
