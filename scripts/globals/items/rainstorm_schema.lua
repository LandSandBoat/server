-----------------------------------
-- ID: 6050
-- Rainstorm Schema
-- Teaches the white magic Rainstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(113)
end

itemObject.onItemUse = function(target)
    target:addSpell(113)
end

return itemObject
