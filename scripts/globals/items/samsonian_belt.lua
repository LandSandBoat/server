-----------------------------------
-- ID: 15863
-- Item: samsonian_belt
-- Item Effect: STR +3
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15863 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 60, 15863)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 3)
end

return item_object
