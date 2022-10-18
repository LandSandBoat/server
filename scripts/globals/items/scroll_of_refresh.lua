-----------------------------------
-- ID: 4717
-- Scroll of Refresh
-- Teaches the white magic Refresh
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(109)
end

itemObject.onItemUse = function(target)
    target:addSpell(109)
end

return itemObject
