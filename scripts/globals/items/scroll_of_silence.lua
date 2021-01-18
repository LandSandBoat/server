-----------------------------------
-- ID: 4667
-- Scroll of Silence
-- Teaches the white magic Silence
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(59)
end

item_object.onItemUse = function(target)
    target:addSpell(59)
end

return item_object
