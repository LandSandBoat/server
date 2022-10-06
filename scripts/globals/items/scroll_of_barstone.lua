-----------------------------------
-- ID: 4671
-- Scroll of Barstone
-- Teaches the white magic Barstone
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(63)
end

itemObject.onItemUse = function(target)
    target:addSpell(63)
end

return itemObject
