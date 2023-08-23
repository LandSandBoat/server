-----------------------------------
-- ID: 4669
-- Scroll of Barblizzard
-- Teaches the white magic Barblizzard
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARBLIZZARD)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARBLIZZARD)
end

return itemObject
