-----------------------------------
-- ID: 15866
-- Item: acrobats_belt
-- Item Effect: AGI +3
-- Duration: 60 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ACROBATS_BELT) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ACROBATS_BELT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.ACROBATS_BELT) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ACROBATS_BELT)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 3)
end

return itemObject
