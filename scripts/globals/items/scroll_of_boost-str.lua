-----------------------------------
-- ID: 5094
-- Scroll of Boost-STR
-- Teaches the white magic Boost-STR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(479)
end

itemObject.onItemUse = function(target)
    target:addSpell(479)
end

return itemObject
