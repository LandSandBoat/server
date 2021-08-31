-----------------------------------
-- ID: 4978
-- Scroll of Foe Requiem III
-- Teaches the song Foe Requiem III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(370)
end

item_object.onItemUse = function(target)
    target:addSpell(370)
end

return item_object
