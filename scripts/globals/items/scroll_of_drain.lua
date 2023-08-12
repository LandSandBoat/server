-----------------------------------
-- ID: 4853
-- Scroll of Drain
-- Teaches the black magic Drain
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DRAIN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DRAIN)
end

return itemObject
