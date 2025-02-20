-----------------------------------
-- ID: 15610
-- Item: sturdy_trousers
-- Item Effect: HP +10
-- Duration: 30 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.MAX_HP_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.STURDY_TROUSERS) ~= nil then
        target:delStatusEffect(xi.effect.MAX_HP_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.STURDY_TROUSERS)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.STURDY_TROUSERS) then
        target:addStatusEffect(xi.effect.MAX_HP_BOOST, 10, 0, 1800, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.STURDY_TROUSERS)
    end
end

return itemObject
