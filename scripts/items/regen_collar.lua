-----------------------------------
-- ID: 15526
-- Item: Regen Collar
-- Item Effect: Restores 40 HP over 120 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.REGEN_COLLAR)
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.REGEN_COLLAR) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 120, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.REGEN_COLLAR)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.REGEN, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
