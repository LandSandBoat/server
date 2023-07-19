-----------------------------------
-- ID: 5039
-- Scroll of Herculean Etude
-- Teaches the song Herculean Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HERCULEAN_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HERCULEAN_ETUDE)
end

return itemObject
