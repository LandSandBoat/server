-----------------------------------
-- ID: 4670
-- Scroll of Baraero
-- Teaches the white magic Baraero
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(62)
end

itemObject.onItemUse = function(target)
    target:addSpell(62)
end

return itemObject
