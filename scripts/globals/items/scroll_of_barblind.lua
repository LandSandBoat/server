-----------------------------------
-- ID: 4683
-- Scroll of Barblind
-- Teaches the white magic Barblind
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(75)
end

itemObject.onItemUse = function(target)
    target:addSpell(75)
end

return itemObject
