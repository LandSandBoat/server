-----------------------------------
-- ID: 4759
-- Scroll of Blizzard III
-- Teaches the black magic Blizzard III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLIZZARD_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZARD_III)
end

return itemObject
