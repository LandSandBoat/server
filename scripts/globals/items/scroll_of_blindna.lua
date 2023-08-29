-----------------------------------
-- ID: 4624
-- Scroll of Blindna
-- Teaches the white magic Blindna
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLINDNA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLINDNA)
end

return itemObject
