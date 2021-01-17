-----------------------------------------
-- ID: 5860
-- Item: galkan_sausage_+2
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Strength 5
-- Intelligence -6
-- Attack 11
-- Ranged Attack 11
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5860)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 5)
    target:addMod(tpz.mod.INT, -6)
    target:addMod(tpz.mod.ATT, 11)
    target:addMod(tpz.mod.RATT, 11)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 5)
    target:delMod(tpz.mod.INT, -6)
    target:delMod(tpz.mod.ATT, 11)
    target:delMod(tpz.mod.RATT, 11)
end

return item_object
