-----------------------------------------
-- ID: 5752
-- Item: Pot-au-feu
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Strength 3
-- Agility 3
-- Intelligence -3
-- Ranged Attk % 15 Cap 60
-- Ranged ACC % 10 Cap 50
-- Enmity -3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5752)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 3)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.INT, -3)
    target:addMod(tpz.mod.FOOD_RATTP, 15)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 60)
    target:addMod(tpz.mod.FOOD_RACCP, 10)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 50)
    target:addMod(tpz.mod.ENMITY, -3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 3)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.INT, -3)
    target:delMod(tpz.mod.FOOD_RATTP, 15)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 60)
    target:delMod(tpz.mod.FOOD_RACCP, 10)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 50)
    target:delMod(tpz.mod.ENMITY, -3)
end

return item_object
