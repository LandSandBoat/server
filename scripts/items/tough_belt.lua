-----------------------------------
-- ID: 15864
-- Item: tough_belt
-- Item Effect: VIT +3
-- Duration: 60 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.VIT_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TOUGH_BELT) ~= nil then
        target:delStatusEffect(xi.effect.VIT_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TOUGH_BELT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.TOUGH_BELT) then
        target:addStatusEffect(xi.effect.VIT_BOOST, 3, 0, 60, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TOUGH_BELT)
    end
end

return itemObject
