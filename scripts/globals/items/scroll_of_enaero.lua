-----------------------------------
-- ID: 4710
-- Scroll of Enaero
-- Teaches the white magic Enaero
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(102)
end

itemObject.onItemUse = function(target)
    target:addSpell(102)
end

return itemObject
