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
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.TWICER) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.TWICER)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.TWICER) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 30, 0, 0, 0, xi.items.TWICER)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DOUBLE_ATTACK, 100)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DOUBLE_ATTACK, 100)
end

return itemObject
