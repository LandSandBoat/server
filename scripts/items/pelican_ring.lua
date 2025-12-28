-----------------------------------
-- ID: 15554
-- Item: Pelican Ring
-- Fishing Skillup Rate increase
-----------------------------------
-- Duration: 20:00 min
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local pelicanStacks = target:countEffect(xi.effect.ENCHANTMENT, xi.item.PELICAN_RING)

    if pelicanStacks >= 2 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return 0
end

itemObject.onItemUse = function(target, user, item, action)
    local effect          = xi.effect.ENCHANTMENT
    local power           = 0
    local tick            = 0
    local duration        = 1200
    local subType         = xi.item.PELICAN_RING
    local subPower        = 0
    local tier            = 0
    local flag            = xi.effectFlag.ON_ZONE

    -- Allow for duplicate effects, max 2
    if target:countEffect(effect, subType) < 2 then
        target:addStatusEffectEx(effect, effect, power, tick, duration, subType, subPower, tier, flag)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.PELICAN_RING_EFFECT, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
