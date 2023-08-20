-----------------------------------
-- ID: 4674
-- Scroll of Barfira
-- Teaches the white magic Barfira
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARFIRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARFIRA)
end

return itemObject
