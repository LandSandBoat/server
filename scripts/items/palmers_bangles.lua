-----------------------------------
-- ID: 14864
-- Item: Palmer's Bangles
-- Item Effect: Gilfinder
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PALMERS_BANGLES) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PALMERS_BANGLES)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.PALMERS_BANGLES) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PALMERS_BANGLES)
    end
end

itemObject.onEffectGain = function(target)
    target:addMod(xi.mod.GILFINDER, 3)
end

itemObject.onEffectLose = function(target)
    target:delMod(xi.mod.GILFINDER, 3)
end

return itemObject
