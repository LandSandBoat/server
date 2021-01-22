-----------------------------------
-- ID: 6214
-- Item: slice of margherita pizza +1
-- Food Effect: 60 minutes, all Races
-----------------------------------
-- HP +35
-- Accuracy+10% (Max. 9)
-- Attack+10% (Max. 11)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6214)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 35)
    target:addMod(tpz.mod.FOOD_ACCP, 10)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 9)
    target:addMod(tpz.mod.FOOD_ATTP, 10)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 11)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 35)
    target:delMod(tpz.mod.FOOD_ACCP, 10)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 9)
    target:delMod(tpz.mod.FOOD_ATTP, 10)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 11)
end

return item_object
