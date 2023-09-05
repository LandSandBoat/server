-----------------------------------------
-- ID: 15554
-- Item: Pelican Ring
-- Fishing Skillup Rate increase
-----------------------------------------
-- Duration: 20:00 min
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getMod(xi.mod.PELICAN_RING_EFFECT) >= 2 then -- Can stack effects of 2 rings
        return xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.ENCHANTMENT, 0, 0, 1200, 15554, 0, 0, xi.effectFlag.ON_ZONE)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.PELICAN_RING_EFFECT, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.PELICAN_RING_EFFECT, 1)
end

return itemObject
