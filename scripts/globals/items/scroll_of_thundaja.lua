-----------------------------------
-- ID: 4894
-- Scroll of Thundaj
-- Teaches the black magic Thundaj
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(500)
end

item_object.onItemUse = function(target)
    target:addSpell(500)
end

return item_object
