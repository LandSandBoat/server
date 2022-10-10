-----------------------------------
-- ID: 4822
-- Scroll of Flood
-- Teaches the black magic Flood
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(214)
end

itemObject.onItemUse = function(target)
    target:addSpell(214)
end

return itemObject
