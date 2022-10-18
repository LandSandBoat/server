-----------------------------------
-- ID: 4803
-- Scroll of Thundaga II
-- Teaches the black magic Thundaga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(195)
end

itemObject.onItemUse = function(target)
    target:addSpell(195)
end

return itemObject
