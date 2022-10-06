-----------------------------------
-- ID: 4789
-- Scroll of Blizzaga III
-- Teaches the black magic Blizzaga III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(181)
end

itemObject.onItemUse = function(target)
    target:addSpell(181)
end

return itemObject
