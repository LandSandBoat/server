-----------------------------------
-- ID: 4684
-- Scroll of Barsilence
-- Teaches the white magic Barsilence
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(76)
end

itemObject.onItemUse = function(target)
    target:addSpell(76)
end

return itemObject
