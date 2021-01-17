-----------------------------------------
-- ID: 5018
-- Scroll of Puppets Operetta
-- Teaches the song Puppets Operetta
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(410)
end

item_object.onItemUse = function(target)
    target:addSpell(410)
end

return item_object
