-----------------------------------
-- ID: 4663
-- Scroll of Aquaveil
-- Teaches the white magic Aquaveil
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(55)
end

itemObject.onItemUse = function(target)
    target:addSpell(55)
end

return itemObject
