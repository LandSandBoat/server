-----------------------------------
-- ID: 4615
-- Scroll of Curaga
-- Teaches the white magic Curaga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CURAGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURAGA)
end

return itemObject
