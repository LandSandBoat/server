-----------------------------------
-- ID: 14957
-- Item: aiming_gloves
-- Item Effect: Ranged Accuracy +3
-- Duration: 60 seconds (Needs confirmation)
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14957 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, 14957)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.RACC, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.RACC, 3)
end

return item_object
