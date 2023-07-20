-----------------------------------
-- ID: 4768
-- Scroll of Stone II
-- Teaches the black magic Stone II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONE_II)
end

return itemObject
