-----------------------------------
-- ID: 4619
-- Scroll of Curaga V
-- Teaches the white magic Curaga V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CURAGA_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURAGA_V)
end

return itemObject
