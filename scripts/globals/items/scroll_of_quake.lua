-----------------------------------
-- ID: 4818
-- Scroll of Quake
-- Teaches the black magic Quake
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(210)
end

itemObject.onItemUse = function(target)
    target:addSpell(210)
end

return itemObject
