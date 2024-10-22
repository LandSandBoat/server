-----------------------------------
-- ID: 14680
-- Item: Pacifist Ring
-- Item Effect: Enmity -12
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENMITY_DOWN, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PACIFIST_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENMITY_DOWN, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PACIFIST_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.PACIFIST_RING) then
        target:addStatusEffect(xi.effect.ENMITY_DOWN, 12, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PACIFIST_RING)
    end
end

return itemObject
