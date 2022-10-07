-----------------------------------
-- ID: 5059
-- Scroll of Water Carol II
-- Teaches the song Water Carol II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(451)
end

itemObject.onItemUse = function(target)
    target:addSpell(451)
end

return itemObject
