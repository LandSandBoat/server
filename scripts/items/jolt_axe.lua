-----------------------------------
-- ID: 17954
-- Item: jolt_axe
-- Item Effect: Attack +3
-- Duration: 30 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JOLT_AXE) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JOLT_AXE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.JOLT_AXE) then
        target:addStatusEffect(xi.effect.ATTACK_BOOST, 3, 0, 1800, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JOLT_AXE)
    end
end

return itemObject
