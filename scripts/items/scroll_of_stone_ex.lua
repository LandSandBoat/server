-----------------------------------
-- ID: 4607
-- Scroll of Stone (Exclusive)
-- Teaches the black magic Stone
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONE)
end

return itemObject
