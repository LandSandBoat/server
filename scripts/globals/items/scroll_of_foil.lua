-----------------------------------
-- ID: 5102
-- Scroll of Foil
-- Teaches the white magic Foil
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(840)
end

itemObject.onItemUse = function(target)
    target:addSpell(840)
end

return itemObject
