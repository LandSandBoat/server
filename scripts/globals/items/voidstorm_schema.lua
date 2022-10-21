-----------------------------------
-- ID: 6056
-- Voidstorm Schema
-- Teaches the white magic Voidstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(118)
end

itemObject.onItemUse = function(target)
    target:addSpell(118)
end

return itemObject
