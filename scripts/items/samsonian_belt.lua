-----------------------------------
-- ID: 15863
-- Item: samsonian_belt
-- Item Effect: STR +3
-- Duration: 60 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.STR_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SAMSONIAN_BELT) ~= nil then
        target:delStatusEffect(xi.effect.STR_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SAMSONIAN_BELT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.SAMSONIAN_BELT) then
        target:addStatusEffect(xi.effect.STR_BOOST, 3, 0, 60, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SAMSONIAN_BELT)
    end
end

return itemObject
