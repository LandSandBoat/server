-----------------------------------
-- ID: 15867
-- Item: sultans_belt
-- Item Effect: STR +10
-- Duration: 60 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.STR_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SULTANS_BELT) ~= nil then
        target:delStatusEffect(xi.effect.STR_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SULTANS_BELT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.SULTANS_BELT) then
        target:addStatusEffect(xi.effect.STR_BOOST, 10, 0, 60, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SULTANS_BELT)
    end
end

return itemObject
