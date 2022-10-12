-----------------------------------
-- ID: 4802
-- Scroll of Thundaga
-- Teaches the black magic Thundaga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(194)
end

itemObject.onItemUse = function(target)
    target:addSpell(194)
end

return itemObject
