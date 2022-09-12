-----------------------------------
-- ID: 5101
-- Scroll of Arise
-- Teaches the white magic Arise
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(494)
end

item_object.onItemUse = function(target)
    target:addSpell(494)
end

return item_object
