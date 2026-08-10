-----------------------------------
-- ID: 18239
-- Item: Healing Feather
-- Item Effect: Cure Potency +15%
-- Duration: 3 Minutes
-- https://wiki.ffo.jp/html/10079.html
-- TODO: Capture Icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.HEALING_FEATHER) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HEALING_FEATHER)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.HEALING_FEATHER })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.CURE_POTENCY, 15)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HEALING_FEATHER)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
