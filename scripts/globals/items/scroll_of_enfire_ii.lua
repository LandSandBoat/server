-----------------------------------
-- ID: 4722
-- Scroll of Enfire II
-- Teaches the white magic Enfire II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ENFIRE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENFIRE_II)
end

return itemObject
