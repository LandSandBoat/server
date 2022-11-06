-----------------------------------
-- ID: 6054
-- Windstorm Schema
-- Teaches the white magic Windstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(114)
end

itemObject.onItemUse = function(target)
    target:addSpell(114)
end

return itemObject
