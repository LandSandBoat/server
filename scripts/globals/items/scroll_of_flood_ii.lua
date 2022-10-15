-----------------------------------
-- ID: 4823
-- Scroll of Flood II
-- Teaches the black magic Flood II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(215)
end

itemObject.onItemUse = function(target)
    target:addSpell(215)
end

return itemObject
