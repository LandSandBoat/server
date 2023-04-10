-----------------------------------
-- ID: 6052
-- Hailstorm Schema
-- Teaches the white magic Hailstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(116)
end

itemObject.onItemUse = function(target)
    target:addSpell(116)
end

return itemObject
