-----------------------------------
-- ID: 5230
-- Item: love_chocolate
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic Regen While Healing 4
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5230)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 4)
end

return item_object
