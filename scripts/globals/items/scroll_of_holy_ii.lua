-----------------------------------
-- ID: 4629
-- Scroll of Holy II
-- Teaches the white magic Holy II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(22)
end

itemObject.onItemUse = function(target)
    target:addSpell(22)
end

return itemObject
