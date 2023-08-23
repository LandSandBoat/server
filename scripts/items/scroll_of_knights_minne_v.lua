-----------------------------------
-- ID: 5001
-- Scroll of Knights Minne V
-- Teaches the song Mages Ballad V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.KNIGHTS_MINNE_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KNIGHTS_MINNE_V)
end

return itemObject
