-----------------------------------
-- ID: 4804
-- Scroll of Thundaga III
-- Teaches the black magic Thundaga III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(196)
end

itemObject.onItemUse = function(target)
    target:addSpell(196)
end

return itemObject
