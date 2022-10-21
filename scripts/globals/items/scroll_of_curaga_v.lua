-----------------------------------
-- ID: 4619
-- Scroll of Curaga V
-- Teaches the white magic Curaga V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(11)
end

itemObject.onItemUse = function(target)
    target:addSpell(11)
end

return itemObject
