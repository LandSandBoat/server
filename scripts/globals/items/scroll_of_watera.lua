-----------------------------------
-- ID: 4926
-- Scroll of Watera
-- Teaches the black magic Watera
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(838)
end

item_object.onItemUse = function(target)
    target:addSpell(838)
end

return item_object
