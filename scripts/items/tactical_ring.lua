-----------------------------------
-- ID: 14679
-- Item: Tactical Ring
-- Item Effect: Regain 20
-- Duration: 3 Minutes
-- https://wiki.ffo.jp/html/2205.html
-- TODO: Capture Icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.TACTICAL_RING) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TACTICAL_RING)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.TACTICAL_RING })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.REGAIN, 20)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TACTICAL_RING)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
