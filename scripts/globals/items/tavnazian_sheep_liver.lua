-----------------------------------
-- ID: 5154
-- Item: Tavnazian Sheep Liver
-- Food Effect: 5Min, Galka only
-----------------------------------
-- Strength 2
-- Intelligence -4
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:getRace() ~= tpz.race.GALKA) then
        result = tpz.msg.basic.CANNOT_EAT
    elseif target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5154)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 2)
    target:addMod(tpz.mod.INT, -4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 2)
    target:delMod(tpz.mod.INT, -4)
end

return item_object
