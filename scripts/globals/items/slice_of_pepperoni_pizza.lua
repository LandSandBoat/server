-----------------------------------------
-- ID: 6215
-- Item: slice of pepperoni_pizza
-- Food Effect: 30 minutes, all Races
-----------------------------------------
-- HP +30
-- STR+1
-- Accuracy+9% (Max. 10)
-- Attack+10% (Max. 15)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6215)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.STR, 1)
    target:addMod(tpz.mod.FOOD_ACCP, 9)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 10)
    target:addMod(tpz.mod.FOOD_ATTP, 10)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.STR, 1)
    target:delMod(tpz.mod.FOOD_ACCP, 9)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 10)
    target:delMod(tpz.mod.FOOD_ATTP, 10)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 15)
end

return item_object
