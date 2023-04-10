-----------------------------------
-- ID: 4637
-- Scroll of Banish II
-- Teaches the white magic Banish II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(29)
end

itemObject.onItemUse = function(target)
    target:addSpell(29)
end

return itemObject
