-----------------------------------
-- ID: 18231
-- Item: Death Chakram
-- Item Effect: +5% MP
-- Duration: 30 Minutes
-- https://wiki.ffo.jp/html/4399.html
-- TODO: Capture Icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.DEATH_CHAKRAM) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEATH_CHAKRAM)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 1800, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.DEATH_CHAKRAM })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MPP, 5)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEATH_CHAKRAM)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
