-----------------------------------
-- ID: 4994
-- Scroll of Mages Ballad
-- Teaches the song Mages Ballad
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.MAGES_BALLAD)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.MAGES_BALLAD)
end

return itemObject
