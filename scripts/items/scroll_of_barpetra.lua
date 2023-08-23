-----------------------------------
-- ID: 4699
-- Scroll of Barpetra
-- Teaches the white magic Barpetra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARPETRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARPETRA)
end

return itemObject
