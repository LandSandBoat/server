-----------------------------------
-- ID: 15559
-- Item: vision_ring
-- Item Effect: ACC+2 RACC+2
-- Duration: 30 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.VISION_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.VISION_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.VISION_RING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.VISION_RING)
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
