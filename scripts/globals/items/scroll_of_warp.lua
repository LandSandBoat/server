-----------------------------------
-- ID: 4869
-- Scroll of Warp
-- Teaches the black magic Warp
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(261)
end

itemObject.onItemUse = function(target)
    target:addSpell(261)
end

return itemObject
