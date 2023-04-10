-----------------------------------
-- ID: 4624
-- Scroll of Blindna
-- Teaches the white magic Blindna
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(16)
end

itemObject.onItemUse = function(target)
    target:addSpell(16)
end

return itemObject
