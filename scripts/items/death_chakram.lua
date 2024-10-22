-----------------------------------
-- ID: 18231
-- Item: Death Chakram
-- Item Effect: +5% MP
-- Duration 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEATH_CHAKRAM) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEATH_CHAKRAM)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.DEATH_CHAKRAM) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEATH_CHAKRAM)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPP, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPP, 5)
end

return itemObject
