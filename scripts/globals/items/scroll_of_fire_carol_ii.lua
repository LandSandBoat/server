-----------------------------------
-- ID: 5054
-- Scroll of Fire Carol II
-- Teaches the song Fire Carol II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(446)
end

itemObject.onItemUse = function(target)
    target:addSpell(446)
end

return itemObject
