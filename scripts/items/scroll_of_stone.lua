-----------------------------------
-- ID: 4767
-- Scroll of Stone
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
