-----------------------------------
-- ID: 4769
-- Scroll of Stone III
-- Teaches the black magic Stone III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONE_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONE_III)
end

return itemObject
