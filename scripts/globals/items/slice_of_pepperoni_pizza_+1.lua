-----------------------------------
-- ID: 6216
-- Item: slice of pepperoni_pizza_+1
-- Food Effect: 60 minutes, all Races
-----------------------------------
-- HP +35
-- Strength 2
-- Accuracy 9% (caps @ 11)
-- Attack 10% (caps @ 16)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6216)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 35)
    target:addMod(tpz.mod.STR, 2)
    target:addMod(tpz.mod.FOOD_ACCP, 9)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 11)
    target:addMod(tpz.mod.FOOD_ATTP, 10)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 16)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 35)
    target:delMod(tpz.mod.STR, 2)
    target:delMod(tpz.mod.FOOD_ACCP, 9)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 11)
    target:delMod(tpz.mod.FOOD_ATTP, 10)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 16)
end

return item_object
