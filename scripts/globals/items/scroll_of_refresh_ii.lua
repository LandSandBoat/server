-----------------------------------
-- ID: 4850
-- Scroll of Refresh II
-- Teaches the white magic Refresh II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(473)
end

itemObject.onItemUse = function(target)
    target:addSpell(473)
end

return itemObject
