-----------------------------------
-- ID: 4679
-- Scroll of Barwatera
-- Teaches the white magic Barwatera
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(71)
end

itemObject.onItemUse = function(target)
    target:addSpell(71)
end

return itemObject
