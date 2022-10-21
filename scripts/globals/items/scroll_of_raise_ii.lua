-----------------------------------
-- ID: 4621
-- Scroll of Raise II
-- Teaches the white magic Raise II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(13)
end

itemObject.onItemUse = function(target)
    target:addSpell(13)
end

return itemObject
