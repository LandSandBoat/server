-----------------------------------------
-- ID: 5981
-- Item: Plate of Boiled Barnacles +1
-- Food Effect: 60 Mins, All Races
-----------------------------------------
-- Charisma -2
-- Defense % 26 Cap 135
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5981)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.CHR, -2)
    target:addMod(tpz.mod.FOOD_DEFP, 26)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 135)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.CHR, -2)
    target:delMod(tpz.mod.FOOD_DEFP, 26)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 135)
end

return item_object
