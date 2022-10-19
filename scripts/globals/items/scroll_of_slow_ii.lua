-----------------------------------
-- ID: 6569
-- Scroll of Slow II
-- Teaches the white magic Slow II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(79)
end

itemObject.onItemUse = function(target)
    target:addSpell(79)
end

return itemObject
