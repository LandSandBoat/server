-----------------------------------
-- ID: 5861
-- Item: galkan_sausage_+3
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 6
-- Intelligence -7
-- Attack 12
-- Ranged Attack 12
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5861)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.INT, -7)
    target:addMod(tpz.mod.ATT, 12)
    target:addMod(tpz.mod.RATT, 12)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.INT, -7)
    target:delMod(tpz.mod.ATT, 12)
    target:delMod(tpz.mod.RATT, 12)
end

return item_object
