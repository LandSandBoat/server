-----------------------------------------
-- ID: 4326
-- Item: serving_of_frog_flambe
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Dexterity 3
-- Agility 2
-- Mind -2
-- Attack +14% (cap 80)
-- Ranged Attack +14% (cap 80)
-- Evasion 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4326)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.AGI, 2)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.FOOD_ATTP, 14)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 80)
    target:addMod(tpz.mod.EVA, 5)
    target:addMod(tpz.mod.FOOD_RATTP, 14)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 80)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.AGI, 2)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.FOOD_ATTP, 14)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 80)
    target:delMod(tpz.mod.EVA, 5)
    target:delMod(tpz.mod.FOOD_RATTP, 14)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 80)
end

return item_object
