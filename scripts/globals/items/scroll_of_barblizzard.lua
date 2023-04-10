-----------------------------------
-- ID: 4669
-- Scroll of Barblizzard
-- Teaches the white magic Barblizzard
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(61)
end

itemObject.onItemUse = function(target)
    target:addSpell(61)
end

return itemObject
