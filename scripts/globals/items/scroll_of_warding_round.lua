-----------------------------------
-- ID: 5022
-- Scroll of Warding Round
-- Teaches the song Warding Round
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WARDING_ROUND)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WARDING_ROUND)
end

return itemObject
