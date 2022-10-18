-----------------------------------
-- ID: 4825
-- Scroll of Gravity II
-- Teaches the black magic Gravity II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(217)
end

itemObject.onItemUse = function(target)
    target:addSpell(217)
end

return itemObject
