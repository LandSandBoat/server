-----------------------------------
-- ID: 5014
-- Scroll of Herb Pastoral
-- Teaches the song Herb Pastoral
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HERB_PASTORAL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HERB_PASTORAL)
end

return itemObject
