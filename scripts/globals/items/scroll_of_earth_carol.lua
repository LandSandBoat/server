-----------------------------------
-- ID: 5049
-- Scroll of Earth Carol
-- Teaches the song Earth Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(441)
end

itemObject.onItemUse = function(target)
    target:addSpell(441)
end

return itemObject
