-----------------------------------
-- ID: 15559
-- Item: vision_ring
-- Item Effect: ACC+2 RACC+2
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15559 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 15559)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 2)
    target:addMod(xi.mod.RACC, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 2)
    target:delMod(xi.mod.RACC, 2)
end

return itemObject
