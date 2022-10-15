-----------------------------------
-- ID: 4618
-- Scroll of Curaga IV
-- Teaches the white magic Curaga IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(10)
end

itemObject.onItemUse = function(target)
    target:addSpell(10)
end

return itemObject
