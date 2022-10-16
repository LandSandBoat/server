-----------------------------------
-- ID: 4840
-- Scroll of Bio III
-- Teaches the black magic Bio III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(232)
end

itemObject.onItemUse = function(target)
    target:addSpell(232)
end

return itemObject
