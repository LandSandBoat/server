-----------------------------------------
-- ID: 4979
-- Scroll of Foe Requiem IV
-- Teaches the song Foe Requiem IV
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(371)
end

item_object.onItemUse = function(target)
    target:addSpell(371)
end

return item_object
