-----------------------------------
-- ID: 4662
-- Scroll of Stoneskin
-- Teaches the white magic Stoneskin
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(54)
end

itemObject.onItemUse = function(target)
    target:addSpell(54)
end

return itemObject
