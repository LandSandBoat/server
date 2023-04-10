-----------------------------------
-- ID: 4651
-- Scroll of Protect
-- Teaches the white magic Protect
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(43)
end

itemObject.onItemUse = function(target)
    target:addSpell(43)
end

return itemObject
