-----------------------------------
-- ID: 4997
-- Scroll of Knights Minne
-- Teaches the song Mages Ballad
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.KNIGHTS_MINNE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KNIGHTS_MINNE)
end

return itemObject
