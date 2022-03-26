-----------------------------------
-- ID: 5103
-- Scroll of Crusade
-- Teaches the white magic Crusade
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(476)
end

item_object.onItemUse = function(target)
    target:addSpell(476)
end

return item_object
