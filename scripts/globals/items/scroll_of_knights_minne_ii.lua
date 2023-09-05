-----------------------------------
-- ID: 4998
-- Scroll of Knights Minne II
-- Teaches the song Mages Ballad II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.KNIGHTS_MINNE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KNIGHTS_MINNE_II)
end

return itemObject
