-----------------------------------
-- ID: 4698
-- Scroll of Barsilencera
-- Teaches the white magic Barsilencera
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARSILENCERA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARSILENCERA)
end

return itemObject
