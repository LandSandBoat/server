-----------------------------------
-- ID: 15507
-- Item: Purgatory Collar
-- Item Effect: Conserve MP
-- Duration: 45 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PURGATORY_COLLAR) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PURGATORY_COLLAR)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.PURGATORY_COLLAR) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 45, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PURGATORY_COLLAR)
    end
end

itemObject.onEffectGain = function(target)
    -- **Power needs validation**
    target:addMod(xi.mod.CONSERVE_MP, 10)
end

itemObject.onEffectLose = function(target)
    target:delMod(xi.mod.CONSERVE_MP, 10)
end

return itemObject
