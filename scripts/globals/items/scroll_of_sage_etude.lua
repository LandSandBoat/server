-----------------------------------
-- ID: 5043
-- Scroll of Sage Etude
-- Teaches the song Sage Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SAGE_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SAGE_ETUDE)
end

return itemObject
