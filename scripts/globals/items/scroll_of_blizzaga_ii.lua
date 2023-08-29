-----------------------------------
-- ID: 4788
-- Scroll of Blizzaga II
-- Teaches the black magic Blizzaga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLIZZAGA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZAGA_II)
end

return itemObject
