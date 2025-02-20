-----------------------------------
-- ID: 15611
-- Item: sturdy_slacks
-- Item Effect: HP +7, MP +7
-- Duration: 30 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.STURDY_SLACKS) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.STURDY_SLACKS)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.STURDY_SLACKS) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.STURDY_SLACKS)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 7)
    target:addMod(xi.mod.MP, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 7)
    target:delMod(xi.mod.MP, 7)
end

return itemObject
