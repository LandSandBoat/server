-----------------------------------
-- ID: 5033
-- Scroll of Dextrous Etude
-- Teaches the song Dextrous Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DEXTROUS_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DEXTROUS_ETUDE)
end

return itemObject
