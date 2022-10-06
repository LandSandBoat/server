-----------------------------------
-- ID: 5022
-- Scroll of Warding Round
-- Teaches the song Warding Round
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(414)
end

itemObject.onItemUse = function(target)
    target:addSpell(414)
end

return itemObject
