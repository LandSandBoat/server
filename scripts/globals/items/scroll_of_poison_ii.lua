-----------------------------------
-- ID: 4829
-- Scroll of Poison II
-- Teaches the black magic Poison II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(221)
end

itemObject.onItemUse = function(target)
    target:addSpell(221)
end

return itemObject
