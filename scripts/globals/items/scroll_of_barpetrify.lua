-----------------------------------
-- ID: 4685
-- Scroll of Barpetrify
-- Teaches the white magic Barpetrify
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(77)
end

itemObject.onItemUse = function(target)
    target:addSpell(77)
end

return itemObject
