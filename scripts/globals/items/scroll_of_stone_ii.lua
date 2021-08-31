-----------------------------------
-- ID: 4768
-- Scroll of Stone II
-- Teaches the black magic Stone II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(160)
end

item_object.onItemUse = function(target)
    target:addSpell(160)
end

return item_object
