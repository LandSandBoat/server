-----------------------------------
-- ID: 4999
-- Scroll of Knights Minne III
-- Teaches the song Mages Ballad III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(391)
end

itemObject.onItemUse = function(target)
    target:addSpell(391)
end

return itemObject
