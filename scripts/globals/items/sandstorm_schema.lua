-----------------------------------
-- ID: 6053
-- Sandstorm Schema
-- Teaches the white magic Sandstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(99)
end

itemObject.onItemUse = function(target)
    target:addSpell(99)
end

return itemObject
