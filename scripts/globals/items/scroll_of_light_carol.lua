-----------------------------------
-- ID: 5052
-- Scroll of Light Carol
-- Teaches the song Light Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(444)
end

itemObject.onItemUse = function(target)
    target:addSpell(444)
end

return itemObject
