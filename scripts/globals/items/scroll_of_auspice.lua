-----------------------------------
-- ID: 4704
-- Scroll of Auspice
-- Teaches the white magic Auspice
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(96)
end

itemObject.onItemUse = function(target)
    target:addSpell(96)
end

return itemObject
