-----------------------------------
-- ID: 4857
-- Scroll of Blaze Spikes
-- Teaches the black magic Blaze Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLAZE_SPIKES)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLAZE_SPIKES)
end

return itemObject
