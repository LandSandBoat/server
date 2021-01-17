-----------------------------------------
-- ID: 4536
-- Item: Blackened Frog
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Dexterity 2
-- Agility 2
-- Mind -2
-- Attack % 14
-- Attack Cap 75
-- Ranged ATT % 14
-- Ranged ATT Cap 75
-- Evasion +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4536)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.AGI, 2)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.FOOD_ATTP, 14)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 75)
    target:addMod(tpz.mod.FOOD_RATTP, 14)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 75)
    target:addMod(tpz.mod.EVA, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.AGI, 2)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.FOOD_ATTP, 14)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 75)
    target:delMod(tpz.mod.FOOD_RATTP, 14)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 75)
    target:delMod(tpz.mod.EVA, 5)
end

return item_object
