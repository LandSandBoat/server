-----------------------------------
-- ID: 4788
-- Scroll of Blizzaga II
-- Teaches the black magic Blizzaga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(180)
end

itemObject.onItemUse = function(target)
    target:addSpell(180)
end

return itemObject
