-----------------------------------
-- ID: 4739
-- Scroll of Shellra II
-- Teaches the white magic Shellra II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(131)
end

itemObject.onItemUse = function(target)
    target:addSpell(131)
end

return itemObject
