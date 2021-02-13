-----------------------------------
-- ID: 4657
-- Scroll of Shell II
-- Teaches the white magic Shell II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(49)
end

item_object.onItemUse = function(target)
    target:addSpell(49)
end

return item_object
