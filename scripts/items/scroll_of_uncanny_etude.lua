-----------------------------------
-- ID: 5040
-- Scroll of Uncanny Etude
-- Teaches the song Uncanny Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.UNCANNY_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.UNCANNY_ETUDE)
end

return itemObject
