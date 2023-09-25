-----------------------------------
-- ID: 5000
-- Scroll of Knights Minne IV
-- Teaches the song Mages Ballad IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.KNIGHTS_MINNE_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KNIGHTS_MINNE_IV)
end

return itemObject
