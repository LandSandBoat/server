-----------------------------------
-- ID: 4850
-- Scroll of Refresh II
-- Teaches the white magic Refresh II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(473)
end

item_object.onItemUse = function(target)
    target:addSpell(473)
end

return item_object
