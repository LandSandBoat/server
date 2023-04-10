-----------------------------------
-- ID: 4652
-- Scroll of Protect II
-- Teaches the white magic Protect II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(44)
end

itemObject.onItemUse = function(target)
    target:addSpell(44)
end

return itemObject
