-----------------------------------
-- ID: 4653
-- Scroll of Protect III
-- Teaches the white magic Protect III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(45)
end

itemObject.onItemUse = function(target)
    target:addSpell(45)
end

return itemObject
