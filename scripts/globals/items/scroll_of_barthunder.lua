-----------------------------------
-- ID: 4672
-- Scroll of Barthunder
-- Teaches the white magic Barthunder
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(64)
end

item_object.onItemUse = function(target)
    target:addSpell(64)
end

return item_object
