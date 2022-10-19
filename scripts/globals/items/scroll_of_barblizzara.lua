-----------------------------------
-- ID: 4675
-- Scroll of Barblizzara
-- Teaches the white magic Barblizzara
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(67)
end

itemObject.onItemUse = function(target)
    target:addSpell(67)
end

return itemObject
