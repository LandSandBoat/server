-----------------------------------
-- ID: 4777
-- Scroll of Water
-- Teaches the black magic Water
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(169)
end

itemObject.onItemUse = function(target)
    target:addSpell(169)
end

return itemObject
