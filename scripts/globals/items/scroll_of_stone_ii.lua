-----------------------------------
-- ID: 4768
-- Scroll of Stone II
-- Teaches the black magic Stone II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(160)
end

itemObject.onItemUse = function(target)
    target:addSpell(160)
end

return itemObject
