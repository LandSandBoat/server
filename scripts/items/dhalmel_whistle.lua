-----------------------------------
-- ID: 15505
-- Item: dhalmel_whistle
-- Item Effect: AGI +6
-- Duration: 3 minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DHALMEL_WHISTLE) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DHALMEL_WHISTLE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.DHALMEL_WHISTLE) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DHALMEL_WHISTLE)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 6)
end

return itemObject
