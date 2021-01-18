-----------------------------------
-- ID: 18216
-- Item: twicer
-- Item Effect: DOUBLE_ATTACK 100%
-- Duration: 30 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 18216 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 30, 18216)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DOUBLE_ATTACK, 100)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DOUBLE_ATTACK, 100)
end

return item_object
