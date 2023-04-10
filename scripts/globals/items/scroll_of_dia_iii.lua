-----------------------------------
-- ID: 4633
-- Scroll of Dia III
-- Teaches the white magic Dia III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(25)
end

itemObject.onItemUse = function(target)
    target:addSpell(25)
end

return itemObject
