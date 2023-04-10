-----------------------------------
-- ID: 4614
-- Scroll of Cure VI
-- Teaches the white magic Cure VI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(6)
end

itemObject.onItemUse = function(target)
    target:addSpell(6)
end

return itemObject
