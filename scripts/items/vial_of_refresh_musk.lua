-----------------------------------
-- ID: 18241
-- Item: Vial of Refresh Musk
-- Item Effect: 60 seconds
-- Duration: 30 Seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.REFRESH, xi.effectSourceType.EQUIPPED_ITEM, xi.item.VIAL_OF_REFRESH_MUSK) ~= nil then
        target:delStatusEffect(xi.effect.REFRESH, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.VIAL_OF_REFRESH_MUSK)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.VIAL_OF_REFRESH_MUSK) then
        target:addStatusEffect(xi.effect.REFRESH, 3, 3, 30, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.VIAL_OF_REFRESH_MUSK)
    end
end

return itemObject
