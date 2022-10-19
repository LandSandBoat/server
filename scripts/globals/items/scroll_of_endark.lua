-----------------------------------
-- ID: 4707
-- Scroll of Endark
-- Teaches the white magic Endark
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(311)
end

itemObject.onItemUse = function(target)
    target:addSpell(311)
end

return itemObject
