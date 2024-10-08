-----------------------------------
-- ID: 15554
-- Item: Pelican Ring
-- Fishing Skillup Rate increase
-----------------------------------
-- Duration: 20:00 min
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getMod(xi.mod.PELICAN_RING_EFFECT) >= 2 then -- Can stack effects of 2 rings
        return xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return 0
end

itemObject.onItemUse = function(target, user, item)
    local effect   = xi.effect.ENCHANTMENT
    local power    = 0
    local tick     = 0
    local duration = 1200
    local subtype  = xi.item.PELICAN_RING
    local subpower = 0
    local tier     = 0
    local flag     = xi.effectFlag.ON_ZONE

    -- Allow for duplicate enchantment effects, max 2
    if target:getMod(effect, subtype) < 2 then
        target:addStatusEffectEx(effect, effect, power, tick, duration, subtype, subpower, tier, flag)
    end
end

itemObject.onEffectGain = function(target, effect)
    if target:getMod(xi.mod.PELICAN_RING_EFFECT) < 2 then
        target:addMod(xi.mod.PELICAN_RING_EFFECT, 1)
    end
end

itemObject.onEffectLose = function(target, effect)
    if target:getMod(xi.mod.PELICAN_RING_EFFECT) > 0 then
        -- Prevent underflows with the >0 check
        target:delMod(xi.mod.PELICAN_RING_EFFECT, 1)
    end
end

return itemObject
