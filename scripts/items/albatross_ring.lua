-----------------------------------
-- ID: 15555
-- Item: Albatross Ring
-- Enchantment: Fight time +30 seconds
-- Duration: 20 minutes
-- https://wiki.ffo.jp/html/1343.html
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.ALBATROSS_RING_2) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ALBATROSS_RING_2)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 1200, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.ALBATROSS_RING_2 })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ALBATROSS_RING_EFFECT, 1)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ALBATROSS_RING_2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
