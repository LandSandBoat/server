-----------------------------------
-- ID: 5052
-- Scroll of Light Carol
-- Teaches the song Light Carol
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(444)
end

item_object.onItemUse = function(target)
    target:addSpell(444)
end

return item_object
