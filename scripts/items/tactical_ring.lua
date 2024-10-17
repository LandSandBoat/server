-----------------------------------
-- ID: 14679
-- Item: Tactical Ring
-- Item Effect: Regain 20
-- Duration: 2 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TACTICAL_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TACTICAL_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.TACTICAL_RING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 120, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TACTICAL_RING)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGAIN, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGAIN, 20)
end

return itemObject
