-----------------------------------
-- ID: 5078
-- Scroll of Sentinel's Scherzo
-- Teaches the song Sentinel's Scherzo
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(470)
end

item_object.onItemUse = function(target)
    target:addSpell(470)
end

return item_object
