-----------------------------------
-- ID: 4845
-- Scroll of Choke
-- Teaches the black magic Choke
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(237)
end

itemObject.onItemUse = function(target)
    target:addSpell(237)
end

return itemObject
