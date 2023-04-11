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
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.VISION_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.VISION_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.VISION_RING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.VISION_RING)
    end
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
