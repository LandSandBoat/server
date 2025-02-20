-----------------------------------
-- ID: 15487
-- Item: High Breath Mantle
-- Item Effect: HP+38 / Enmity+5
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HIGH_BREATH_MANTLE) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HIGH_BREATH_MANTLE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HIGH_BREATH_MANTLE) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HIGH_BREATH_MANTLE)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 38)
    target:addMod(xi.mod.ENMITY, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 38)
    target:delMod(xi.mod.ENMITY, 5)
end

return itemObject
