-----------------------------------
-- ID: 4686
-- Scroll of Barvirus
-- Teaches the white magic Barvirus
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(78)
end

itemObject.onItemUse = function(target)
    target:addSpell(78)
end

return itemObject
