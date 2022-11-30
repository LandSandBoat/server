-----------------------------------
-- ID: 18216
-- Item: twicer
-- Item Effect: DOUBLE_ATTACK 100%
-- Duration: 30 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 18216 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 30, 18216)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DOUBLE_ATTACK, 100)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DOUBLE_ATTACK, 100)
end

return itemObject
