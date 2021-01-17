-----------------------------------------
-- ID: 5041
-- Scroll of Vital Etude
-- Teaches the song Vital Etude
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(433)
end

item_object.onItemUse = function(target)
    target:addSpell(433)
end

return item_object
