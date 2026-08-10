-----------------------------------
-- ID: 14787
-- Item: Deadeye Earring
-- Item Effect: Ranged Attack 20
-- Duration: 3 Minutes
-- https://wiki.ffo.jp/html/10067.html
-- TODO: Capture Icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.DEADEYE_EARRING) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEADEYE_EARRING)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.DEADEYE_EARRING })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.RATT, 20)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEADEYE_EARRING)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
