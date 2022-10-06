-----------------------------------
-- ID: 4807
-- Scroll of Waterga
-- Teaches the black magic Waterga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(199)
end

itemObject.onItemUse = function(target)
    target:addSpell(199)
end

return itemObject
