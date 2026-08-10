-----------------------------------
-- ID: 18240
-- Item: Spirit Lantern
-- Item Effect: Magic Attack +10
-- Duration: 3 Minutes
-- https://wiki.ffo.jp/html/10080.html
-- TODO: Capture Icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.SPIRIT_LANTERN) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SPIRIT_LANTERN)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.SPIRIT_LANTERN })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MATT, 10)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SPIRIT_LANTERN)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
