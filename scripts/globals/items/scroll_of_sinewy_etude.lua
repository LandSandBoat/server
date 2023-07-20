-----------------------------------
-- ID: 5032
-- Scroll of Sinewy Etude
-- Teaches the song Sinewy Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SINEWY_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SINEWY_ETUDE)
end

return itemObject
