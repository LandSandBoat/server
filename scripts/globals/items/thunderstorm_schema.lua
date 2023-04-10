-----------------------------------
-- ID: 6051
-- Thunderstorm Schema
-- Teaches the white magic Thunderstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(117)
end

itemObject.onItemUse = function(target)
    target:addSpell(117)
end

return itemObject
