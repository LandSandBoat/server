-----------------------------------------
-- ID: 5039
-- Scroll of Herculean Etude
-- Teaches the song Herculean Etude
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(431)
end

item_object.onItemUse = function(target)
    target:addSpell(431)
end

return item_object
