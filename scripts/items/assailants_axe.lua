-----------------------------------
-- ID: 18488
-- Item: assailants_axe
-- Item Effect: Acc +3
-- Duration: 30 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ASSAILANTS_AXE) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ASSAILANTS_AXE)
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.ASSAILANTS_AXE) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 1800, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.ASSAILANTS_AXE })
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ACC, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
