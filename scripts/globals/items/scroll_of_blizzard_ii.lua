-----------------------------------
-- ID: 4758
-- Scroll of Blizzard II
-- Teaches the black magic Blizzard II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(150)
end

itemObject.onItemUse = function(target)
    target:addSpell(150)
end

return itemObject
