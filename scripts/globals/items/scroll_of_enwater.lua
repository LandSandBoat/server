-----------------------------------
-- ID: 4713
-- Scroll of Enwater
-- Teaches the white magic Enwater
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(105)
end

itemObject.onItemUse = function(target)
    target:addSpell(105)
end

return itemObject
