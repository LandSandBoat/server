-----------------------------------
-- ID: 4793
-- Scroll of Aeroga II
-- Teaches the black magic Aeroga II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(185)
end

item_object.onItemUse = function(target)
    target:addSpell(185)
end

return item_object
