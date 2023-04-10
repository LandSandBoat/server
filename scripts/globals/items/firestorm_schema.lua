-----------------------------------
-- ID: 6049
-- Firestorm Schema
-- Teaches the white magic Firestorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(115)
end

itemObject.onItemUse = function(target)
    target:addSpell(115)
end

return itemObject
