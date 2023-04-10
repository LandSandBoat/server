-----------------------------------
-- ID: 4665
-- Scroll of Haste
-- Teaches the white magic Haste
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(57)
end

itemObject.onItemUse = function(target)
    target:addSpell(57)
end

return itemObject
