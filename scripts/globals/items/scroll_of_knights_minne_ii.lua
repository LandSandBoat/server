-----------------------------------
-- ID: 4998
-- Scroll of Knights Minne II
-- Teaches the song Mages Ballad II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(390)
end

itemObject.onItemUse = function(target)
    target:addSpell(390)
end

return itemObject
