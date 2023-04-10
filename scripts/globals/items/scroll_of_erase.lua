-----------------------------------
-- ID: 4751
-- Scroll of Erase
-- Teaches the white magic Erase
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(143)
end

itemObject.onItemUse = function(target)
    target:addSpell(143)
end

return itemObject
