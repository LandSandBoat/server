-----------------------------------
-- ID: 4702
-- Scroll of Sacrifice
-- Teaches the white magic Sacrifice
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(94)
end

itemObject.onItemUse = function(target)
    target:addSpell(94)
end

return itemObject
