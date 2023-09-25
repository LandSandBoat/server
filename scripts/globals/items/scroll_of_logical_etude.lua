-----------------------------------
-- ID: 5044
-- Scroll of Logical Etude
-- Teaches the song Logical Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.LOGICAL_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LOGICAL_ETUDE)
end

return itemObject
