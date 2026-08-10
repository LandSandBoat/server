-----------------------------------
-- ID: 14681
-- Item: Getsul Ring
-- Item Effect: +20% HP
-- Duration: 10 Minutes
-- https://wiki.ffo.jp/html/10072.html
-- TODO: Capture Icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.GETSUL_RING) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.GETSUL_RING)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 600, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.GETSUL_RING })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.HPP, 20)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.GETSUL_RING)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
