-----------------------------------
-- ID: 15783
-- Item: Armored Ring
-- Item Effect: Defence +8
-- Duration 30 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ARMORED_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ARMORED_RING)
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.ARMORED_RING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 1800, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.ARMORED_RING })
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEF, 8)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
