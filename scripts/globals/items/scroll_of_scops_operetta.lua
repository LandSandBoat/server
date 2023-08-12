-----------------------------------
-- ID: 5017
-- Scroll of Scops Operetta
-- Teaches the song Scops Operetta
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SCOPS_OPERETTA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SCOPS_OPERETTA)
end

return itemObject
