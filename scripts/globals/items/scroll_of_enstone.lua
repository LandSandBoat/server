-----------------------------------
-- ID: 4711
-- Scroll of Enstone
-- Teaches the white magic Enstone
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(103)
end

itemObject.onItemUse = function(target)
    target:addSpell(103)
end

return itemObject
