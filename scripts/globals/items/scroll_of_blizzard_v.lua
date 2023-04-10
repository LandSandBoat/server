-----------------------------------
-- ID: 4761
-- Scroll of Blizzard V
-- Teaches the black magic Blizzard V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(153)
end

itemObject.onItemUse = function(target)
    target:addSpell(153)
end

return itemObject
