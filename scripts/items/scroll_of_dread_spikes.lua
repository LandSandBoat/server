-----------------------------------
-- ID: 4885
-- Scroll of Dread Spikes
-- Teaches the black magic Dread Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DREAD_SPIKES)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DREAD_SPIKES)
end

return itemObject
