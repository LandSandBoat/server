-----------------------------------
-- ID: 4700
-- Scroll of Barvira
-- Teaches the white magic Barvira
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(92)
end

itemObject.onItemUse = function(target)
    target:addSpell(92)
end

return itemObject
