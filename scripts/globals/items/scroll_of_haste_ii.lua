-----------------------------------
-- ID: 4692
-- Scroll of Haste II
-- Teaches the white magic Haste II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(511)
end

itemObject.onItemUse = function(target)
    target:addSpell(511)
end

return itemObject
