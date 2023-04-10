-----------------------------------
-- ID: 4741
-- Scroll of Shellra IV
-- Teaches the white magic Shellra IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(133)
end

itemObject.onItemUse = function(target)
    target:addSpell(133)
end

return itemObject
