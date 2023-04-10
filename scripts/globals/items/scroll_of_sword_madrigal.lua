-----------------------------------
-- ID: 5007
-- Scroll of Sword Madrigal
-- Teaches the song Sword Madrigal
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(399)
end

itemObject.onItemUse = function(target)
    target:addSpell(399)
end

return itemObject
