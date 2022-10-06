-----------------------------------
-- ID: 4658
-- Scroll of Shell III
-- Teaches the white magic Shell III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(50)
end

itemObject.onItemUse = function(target)
    target:addSpell(50)
end

return itemObject
