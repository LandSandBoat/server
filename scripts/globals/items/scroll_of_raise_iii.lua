-----------------------------------
-- ID: 4748
-- Scroll of Raise II
-- Teaches the white magic Raise III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(140)
end

itemObject.onItemUse = function(target)
    target:addSpell(140)
end

return itemObject
