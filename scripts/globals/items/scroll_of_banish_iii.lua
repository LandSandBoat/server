-----------------------------------
-- ID: 4638
-- Scroll of Banish III
-- Teaches the white magic Banish III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(30)
end

itemObject.onItemUse = function(target)
    target:addSpell(30)
end

return itemObject
