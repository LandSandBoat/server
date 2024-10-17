-----------------------------------
-- ID: 15269
-- Item: eldritch_horn_hairpin
-- Item Effect: INT+3 MND+3
-- Duration: 30 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ELDRITCH_HORN_HAIRPIN) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ELDRITCH_HORN_HAIRPIN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.ELDRITCH_HORN_HAIRPIN) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ELDRITCH_HORN_HAIRPIN)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.MND, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.MND, 3)
end

return itemObject
