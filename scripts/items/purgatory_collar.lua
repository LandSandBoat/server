-----------------------------------
-- ID: 15507
-- Item: Purgatory Collar
-- Item Effect: Conserve MP
-- Duration: 45 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, user)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PURGATORY_COLLAR) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PURGATORY_COLLAR)
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.PURGATORY_COLLAR) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 45, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.PURGATORY_COLLAR })
    end
end

itemObject.onEffectGain = function(target, effect)
    -- **Power needs validation**
    effect:addMod(xi.mod.CONSERVE_MP, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
