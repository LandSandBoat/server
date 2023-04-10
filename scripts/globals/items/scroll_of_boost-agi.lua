-----------------------------------
-- ID: 5097
-- Scroll of Boost-AGI
-- Teaches the white magic Boost-AGI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(482)
end

itemObject.onItemUse = function(target)
    target:addSpell(482)
end

return itemObject
