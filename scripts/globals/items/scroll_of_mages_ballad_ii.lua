-----------------------------------
-- ID: 4995
-- Scroll of Mages Ballad II
-- Teaches the song Mages Ballad II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(387)
end

itemObject.onItemUse = function(target)
    target:addSpell(387)
end

return itemObject
