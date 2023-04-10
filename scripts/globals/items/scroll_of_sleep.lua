-----------------------------------
-- ID: 4861
-- Scroll of Sleep
-- Teaches the black magic Sleep
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(253)
end

itemObject.onItemUse = function(target)
    target:addSpell(253)
end

return itemObject
