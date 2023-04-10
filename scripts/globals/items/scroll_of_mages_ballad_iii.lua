-----------------------------------
-- ID: 4996
-- Scroll of Mages Ballad III
-- Teaches the song Mages Ballad III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(388)
end

itemObject.onItemUse = function(target)
    target:addSpell(388)
end

return itemObject
