-----------------------------------
-- ID: 4698
-- Scroll of Barsilencera
-- Teaches the white magic Barsilencera
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(90)
end

itemObject.onItemUse = function(target)
    target:addSpell(90)
end

return itemObject
