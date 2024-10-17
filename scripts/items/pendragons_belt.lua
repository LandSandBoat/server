-----------------------------------
-- ID: 15869
-- Item: pendragons_belt
-- Item Effect: DEX +10
-- Duration: 60 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PENDRAGONS_BELT) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PENDRAGONS_BELT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.PENDRAGONS_BELT) then
        target:addStatusEffect(xi.effect.DEX_BOOST, 10, 0, 60, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PENDRAGONS_BELT)
    end
end

return itemObject
