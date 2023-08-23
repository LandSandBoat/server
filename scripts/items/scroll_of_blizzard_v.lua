-----------------------------------
-- ID: 4761
-- Scroll of Blizzard V
-- Teaches the black magic Blizzard V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLIZZARD_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZARD_V)
end

return itemObject
