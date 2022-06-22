-----------------------------------
-- ID: 4925
-- Scroll of Thundara II
-- Teaches the black magic Thundara II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(837)
end

item_object.onItemUse = function(target)
    target:addSpell(837)
end

return item_object
