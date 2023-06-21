-----------------------------------
-- ID: 5157
-- Item: serving_of_marbled_steak
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength 6
-- Agility 1
-- Intelligence -3
-- Attack % 18
-- Attack Cap 95
-- Ranged ATT % 18
-- Ranged ATT Cap 95
-- Lizard Killer 5
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5157)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.FOOD_ATTP, 18)
    target:addMod(xi.mod.FOOD_ATT_CAP, 95)
    target:addMod(xi.mod.FOOD_RATTP, 18)
    target:addMod(xi.mod.FOOD_RATT_CAP, 95)
    target:addMod(xi.mod.LIZARD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.FOOD_ATTP, 18)
    target:delMod(xi.mod.FOOD_ATT_CAP, 95)
    target:delMod(xi.mod.FOOD_RATTP, 18)
    target:delMod(xi.mod.FOOD_RATT_CAP, 95)
    target:delMod(xi.mod.LIZARD_KILLER, 5)
end

return itemObject
