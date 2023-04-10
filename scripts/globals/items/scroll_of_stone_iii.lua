-----------------------------------
-- ID: 4769
-- Scroll of Stone III
-- Teaches the black magic Stone III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(161)
end

itemObject.onItemUse = function(target)
    target:addSpell(161)
end

return itemObject
