-----------------------------------
-- ID: 4980
-- Scroll of Foe Requiem V
-- Teaches the song Foe Requiem V
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(372)
end

item_object.onItemUse = function(target)
    target:addSpell(372)
end

return item_object
