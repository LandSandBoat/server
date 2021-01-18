-----------------------------------
-- ID: 4438
-- Item: dhalmel_steak
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 4
-- Intelligence -2
-- Attack % 25
-- Attack Cap 45
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4438)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 4)
    target:addMod(tpz.mod.INT, -2)
    target:addMod(tpz.mod.ATTP, 25)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 45)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 4)
    target:delMod(tpz.mod.INT, -2)
    target:delMod(tpz.mod.ATTP, 25)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 45)
end

return item_object
