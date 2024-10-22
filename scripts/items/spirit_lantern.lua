-----------------------------------
-- ID: 18240
-- Item: Spirit Lantern
-- Item Effect: Magic Damage +10%
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SPIRIT_LANTERN) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SPIRIT_LANTERN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.SPIRIT_LANTERN) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SPIRIT_LANTERN)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MAGIC_DAMAGE, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MAGIC_DAMAGE, 10)
end

return itemObject
