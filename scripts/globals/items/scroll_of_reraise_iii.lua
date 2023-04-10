-----------------------------------
-- ID: 4750
-- Scroll of Reraise III
-- Teaches the white magic Reraise III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(142)
end

itemObject.onItemUse = function(target)
    target:addSpell(142)
end

return itemObject
