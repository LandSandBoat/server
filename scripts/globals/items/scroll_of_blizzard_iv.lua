-----------------------------------
-- ID: 4760
-- Scroll of Blizzard IV
-- Teaches the black magic Blizzard IV
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(152)
end

item_object.onItemUse = function(target)
    target:addSpell(152)
end

return item_object
