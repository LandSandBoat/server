-----------------------------------
-- ID: 5074
-- Scroll of Maiden's Virelai
-- Teaches the song Maiden's Virelai
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.MAIDENS_VIRELAI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.MAIDENS_VIRELAI)
end

return itemObject
