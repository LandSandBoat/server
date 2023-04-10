-----------------------------------
-- ID: 4708
-- Scroll of Enfire
-- Teaches the white magic Enfire
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(100)
end

itemObject.onItemUse = function(target)
    target:addSpell(100)
end

return itemObject
