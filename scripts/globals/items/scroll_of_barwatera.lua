-----------------------------------
-- ID: 4679
-- Scroll of Barwatera
-- Teaches the white magic Barwatera
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARWATERA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARWATERA)
end

return itemObject
