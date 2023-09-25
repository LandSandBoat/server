-----------------------------------
-- ID: 4999
-- Scroll of Knights Minne III
-- Teaches the song Mages Ballad III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.KNIGHTS_MINNE_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KNIGHTS_MINNE_III)
end

return itemObject
