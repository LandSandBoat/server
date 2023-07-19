-----------------------------------
-- ID: 4710
-- Scroll of Enaero
-- Teaches the white magic Enaero
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ENAERO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENAERO)
end

return itemObject
