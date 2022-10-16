-----------------------------------
-- ID: 5078
-- Scroll of Sentinel's Scherzo
-- Teaches the song Sentinel's Scherzo
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(470)
end

itemObject.onItemUse = function(target)
    target:addSpell(470)
end

return itemObject
