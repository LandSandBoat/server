-----------------------------------
-- ID: 4859
-- Scroll of Shock Spikes
-- Teaches the black magic Shock Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SHOCK_SPIKES)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHOCK_SPIKES)
end

return itemObject
