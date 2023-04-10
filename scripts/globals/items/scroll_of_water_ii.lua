-----------------------------------
-- ID: 4778
-- Scroll of Water II
-- Teaches the black magic Water II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(170)
end

itemObject.onItemUse = function(target)
    target:addSpell(170)
end

return itemObject
