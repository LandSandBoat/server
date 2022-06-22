-----------------------------------
-- ID: 4917
-- Scroll of Fira II
-- Teaches the black magic Fira II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(829)
end

item_object.onItemUse = function(target)
    target:addSpell(829)
end

return item_object
