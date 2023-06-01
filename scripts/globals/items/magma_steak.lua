-----------------------------------
-- ID: 6071
-- Item: Magma Steak
-- Food Effect: 180 Min, All Races
-----------------------------------
-- Strength +8
-- Attack +23% Cap 180
-- Ranged Attack +23% Cap 180
-- Vermin Killer +5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 6071)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 8)
    target:addMod(xi.mod.FOOD_ATTP, 23)
    target:addMod(xi.mod.FOOD_ATT_CAP, 180)
    target:addMod(xi.mod.FOOD_RATTP, 23)
    target:addMod(xi.mod.FOOD_RATT_CAP, 180)
    target:addMod(xi.mod.VERMIN_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 8)
    target:delMod(xi.mod.FOOD_ATTP, 23)
    target:delMod(xi.mod.FOOD_ATT_CAP, 180)
    target:delMod(xi.mod.FOOD_RATTP, 23)
    target:delMod(xi.mod.FOOD_RATT_CAP, 180)
    target:delMod(xi.mod.VERMIN_KILLER, 5)
end

return itemObject
