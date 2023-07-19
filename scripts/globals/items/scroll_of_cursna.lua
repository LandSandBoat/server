-----------------------------------
-- ID: 4628
-- Scroll of Cursna
-- Teaches the white magic Cursna
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CURSNA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURSNA)
end

return itemObject
