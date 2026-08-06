-----------------------------------
-- ID: 14678
-- Item: Assassin's Ring
-- Item Effect: Ranged Accuracy 20
-- Duration: 5 Minutes
-- https://wiki.ffo.jp/html/10071.html
-- TODO: Capture icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.ASSASSINS_RING) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ASSASSINS_RING)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 300, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.ASSASSINS_RING })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.RACC, 20)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ASSASSINS_RING)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
