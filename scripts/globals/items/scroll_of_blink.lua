-----------------------------------
-- ID: 4661
-- Scroll of Blink
-- Teaches the white magic Blink
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(53)
end

itemObject.onItemUse = function(target)
    target:addSpell(53)
end

return itemObject
