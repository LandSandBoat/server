-----------------------------------
-- ID: 15558
-- Item: mighty_ring
-- Item Effect: Attack +5, Ranged Attack +5
-- Duration: 30 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MIGHTY_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MIGHTY_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.MIGHTY_RING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MIGHTY_RING)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ATT, 5)
    target:addMod(xi.mod.RATT, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATT, 5)
    target:delMod(xi.mod.RATT, 5)
end

return itemObject
