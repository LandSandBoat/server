-----------------------------------
-- ID: 5571
-- Item: Slice of Karakul Meat
-- Effect: 5 Minutes, food effect, Galka Only
-----------------------------------
-- Strength +2
-- Intelligence -4
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:getRace() ~= xi.race.GALKA) then
        result = xi.msg.basic.CANNOT_EAT
    end
    if (target:getMod(xi.mod.EAT_RAW_MEAT) == 1) then
        result = 0
    end
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5571)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.INT, -4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.INT, -4)
end

return item_object
