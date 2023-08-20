-----------------------------------
-- ID: 4789
-- Scroll of Blizzaga III
-- Teaches the black magic Blizzaga III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLIZZAGA_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZAGA_III)
end

return itemObject
