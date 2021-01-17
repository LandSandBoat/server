-----------------------------------------
-- ID: 5043
-- Scroll of Sage Etude
-- Teaches the song Sage Etude
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(435)
end

item_object.onItemUse = function(target)
    target:addSpell(435)
end

return item_object
