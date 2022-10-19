-----------------------------------
-- ID: 5098
-- Scroll of Boost-INT
-- Teaches the white magic Boost-INT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(483)
end

itemObject.onItemUse = function(target)
    target:addSpell(483)
end

return itemObject
