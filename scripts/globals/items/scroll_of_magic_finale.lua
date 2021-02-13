-----------------------------------
-- ID: 5070
-- Scroll of Magic Finale
-- Teaches the song Magic Finale
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(462)
end

item_object.onItemUse = function(target)
    target:addSpell(462)
end

return item_object
