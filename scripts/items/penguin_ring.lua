-----------------------------------
-- ID: 15556
-- Item: Penguin Ring
-- Enchantment: Longer input window while fishing
-- Duration: 20 minutes
-- https://wiki.ffo.jp/html/1344.html
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.PENGUIN_RING_2) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PENGUIN_RING_2)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 1200, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.PENGUIN_RING_2 })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.PENGUIN_RING_EFFECT, 1)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PENGUIN_RING_2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
