-----------------------------------
-- ID: 5050
-- Scroll of Lightning Carol
-- Teaches the song Lightning Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(442)
end

itemObject.onItemUse = function(target)
    target:addSpell(442)
end

return itemObject
