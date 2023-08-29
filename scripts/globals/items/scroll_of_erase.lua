-----------------------------------
-- ID: 4751
-- Scroll of Erase
-- Teaches the white magic Erase
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ERASE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ERASE)
end

return itemObject
