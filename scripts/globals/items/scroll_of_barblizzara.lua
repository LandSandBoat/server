-----------------------------------
-- ID: 4675
-- Scroll of Barblizzara
-- Teaches the white magic Barblizzara
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARBLIZZARA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARBLIZZARA)
end

return itemObject
