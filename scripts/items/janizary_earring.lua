-----------------------------------
-- ID: 14785
-- Item: Janizary Earring
-- Item Effect: Defence +32
-- Duration 3 Minutes
-- https://wiki.ffo.jp/html/10065.html
-- TODO: Capture Icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.JANIZARY_EARRING) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JANIZARY_EARRING)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.JANIZARY_EARRING })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEF, 32)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JANIZARY_EARRING)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
