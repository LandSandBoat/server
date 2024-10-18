-----------------------------------
-- ID: 14785
-- Item: Janizary Earring
-- Item Effect: Defence +32
-- Duration 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JANIZARY_EARRING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JANIZARY_EARRING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.JANIZARY_EARRING) then
        target:addStatusEffect(xi.effect.DEFENSE_BOOST, 32, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JANIZARY_EARRING)
    end
end

return itemObject
