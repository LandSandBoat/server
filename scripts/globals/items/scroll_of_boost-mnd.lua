-----------------------------------
-- ID: 5099
-- Scroll of Boost-MND
-- Teaches the white magic Boost-MND
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(484)
end

itemObject.onItemUse = function(target)
    target:addSpell(484)
end

return itemObject
