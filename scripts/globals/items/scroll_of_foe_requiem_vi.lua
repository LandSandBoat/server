-----------------------------------
-- ID: 4981
-- Scroll of Foe Requiem VI
-- Teaches the song Foe Requiem VI
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(373)
end

item_object.onItemUse = function(target)
    target:addSpell(373)
end

return item_object
