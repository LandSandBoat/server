-----------------------------------
-- ID: 15782
-- Item: Manashell Ring
-- Item Effect: MP +9
-- Duration: 3 minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffectBySource(xi.effect.MAX_MP_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MANASHELL_RING) ~= nil then
        target:delStatusEffect(xi.effect.MAX_MP_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MANASHELL_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.MANASHELL_RING) then
        target:addStatusEffect(xi.effect.MAX_MP_BOOST, 9, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MANASHELL_RING)
    end
end

return itemObject
