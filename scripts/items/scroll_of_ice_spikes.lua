-----------------------------------
-- ID: 4858
-- Scroll of Ice Spikes
-- Teaches the black magic Ice Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ICE_SPIKES)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ICE_SPIKES)
end

return itemObject
