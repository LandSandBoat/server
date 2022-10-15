-----------------------------------
-- ID: 4608, 4609
-- Scroll of Cure
-- Teaches the white magic Cure
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(1)
end

itemObject.onItemUse = function(target)
    target:addSpell(1)
end

return itemObject
