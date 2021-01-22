-----------------------------------
-- ID: 5980
-- Item: Plate of Boiled Barnacles
-- Food Effect: 30 Mins, All Races
-----------------------------------
-- Charisma -3
-- Defense % 25 Cap 130
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5980)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.CHR, -3)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 130)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.CHR, -3)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 130)
end

return item_object
