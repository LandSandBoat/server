-----------------------------------
-- ID: 4735
-- Scroll of Protectra III
-- Teaches the white magic Protectra III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(127)
end

itemObject.onItemUse = function(target)
    target:addSpell(127)
end

return itemObject
