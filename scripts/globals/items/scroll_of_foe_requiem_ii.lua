-----------------------------------
-- ID: 4977
-- Scroll of Foe Requiem II
-- Teaches the song Foe Requiem II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(369)
end

item_object.onItemUse = function(target)
    target:addSpell(369)
end

return item_object
