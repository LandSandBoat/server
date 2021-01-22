-----------------------------------
-- ID: 4982
-- Scroll of Foe Requiem VII
-- Teaches the song Foe Requiem VII
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(374)
end

item_object.onItemUse = function(target)
    target:addSpell(374)
end

return item_object
