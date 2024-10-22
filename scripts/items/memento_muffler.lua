-----------------------------------
-- ID: 13173
-- Item: Memento Muffler
-- Item Effect: VIT +7
-- Duration: 3 minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffectBySource(xi.effect.VIT_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MEMENTO_MUFFLER) ~= nil then
        target:delStatusEffect(xi.effect.VIT_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MEMENTO_MUFFLER)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.MEMENTO_MUFFLER) then
        target:addStatusEffect(xi.effect.VIT_BOOST, 7, 0, 300, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MEMENTO_MUFFLER)
    end
end

return itemObject
