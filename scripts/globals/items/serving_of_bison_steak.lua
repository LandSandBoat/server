-----------------------------------
-- ID: 5142
-- Item: serving_of_bison_steak
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 6
-- Agility 1
-- Intelligence -3
-- Attack % 18
-- Attack Cap 90
-- Ranged ATT % 18
-- Ranged ATT Cap 90
-- Lizard Killer 5
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5142)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.FOOD_ATTP, 18)
    target:addMod(xi.mod.FOOD_ATT_CAP, 90)
    target:addMod(xi.mod.FOOD_RATTP, 18)
    target:addMod(xi.mod.FOOD_RATT_CAP, 90)
    target:addMod(xi.mod.LIZARD_KILLER, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.FOOD_ATTP, 18)
    target:delMod(xi.mod.FOOD_ATT_CAP, 90)
    target:delMod(xi.mod.FOOD_RATTP, 18)
    target:delMod(xi.mod.FOOD_RATT_CAP, 90)
    target:delMod(xi.mod.LIZARD_KILLER, 5)
end

return item_object
