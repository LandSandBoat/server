-----------------------------------
-- ID: 5086
-- Scroll of Regen V
-- Teaches the white magic Regen V
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(504)
end

item_object.onItemUse = function(target)
    target:addSpell(504)
end

return item_object
