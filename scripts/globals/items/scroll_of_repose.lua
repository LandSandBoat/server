-----------------------------------
-- ID: 4721
-- Scroll of Repose
-- Teaches the white magic Repose
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(98)
end

item_object.onItemUse = function(target)
    target:addSpell(98)
end

return item_object
