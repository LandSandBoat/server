-----------------------------------
-- ID: 4740
-- Scroll of Shellra III
-- Teaches the white magic Shellra III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(132)
end

itemObject.onItemUse = function(target)
    target:addSpell(132)
end

return itemObject
