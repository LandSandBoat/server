-----------------------------------
-- ID: 14957
-- Item: aiming_gloves
-- Item Effect: RACC +3
-- Duration: 60 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.AIMING_GLOVES) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.AIMING_GLOVES)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.AIMING_GLOVES) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.AIMING_GLOVES)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.RACC, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.RACC, 3)
end

return itemObject
