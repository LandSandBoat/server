-----------------------------------
-- ID: 4731
-- Scroll of Teleport-Dem
-- Teaches the white magic Teleport-Dem
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(123)
end

itemObject.onItemUse = function(target)
    target:addSpell(123)
end

return itemObject
