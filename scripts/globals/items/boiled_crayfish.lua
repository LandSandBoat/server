-----------------------------------------
-- ID: 4535
-- Item: Boiled Crayfish
-- Food Effect: 30Min, All Races
-----------------------------------------
-- defense % 30
-- defense % 25
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4535)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_DEFP, 30)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 25)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_DEFP, 30)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 25)
end

return item_object
