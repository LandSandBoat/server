-----------------------------------
-- ID: 4812
-- Scroll of Flare
-- Teaches the black magic Flare
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(204)
end

item_object.onItemUse = function(target)
    target:addSpell(204)
end

return item_object
