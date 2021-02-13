-----------------------------------
-- ID: 5007
-- Scroll of Sword Madrigal
-- Teaches the song Sword Madrigal
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(399)
end

item_object.onItemUse = function(target)
    target:addSpell(399)
end

return item_object
