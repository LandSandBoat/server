-----------------------------------
-- ID: 5640
-- Item: M&P Cracker
-- Food Effect: 3Min, All Races
-----------------------------------
-- Vitality 5
-- Mind -5
-- Defense % 25
-- Attack Cap 154
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 5640)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 5)
    target:addMod(tpz.mod.MND, -5)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 154)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 5)
    target:delMod(tpz.mod.MND, -5)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 154)
end

return item_object
