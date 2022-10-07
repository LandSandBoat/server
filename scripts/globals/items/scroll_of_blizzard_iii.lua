-----------------------------------
-- ID: 4759
-- Scroll of Blizzard III
-- Teaches the black magic Blizzard III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(151)
end

itemObject.onItemUse = function(target)
    target:addSpell(151)
end

return itemObject
