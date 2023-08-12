-----------------------------------
-- ID: 5018
-- Scroll of Puppets Operetta
-- Teaches the song Puppets Operetta
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PUPPETS_OPERETTA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PUPPETS_OPERETTA)
end

return itemObject
