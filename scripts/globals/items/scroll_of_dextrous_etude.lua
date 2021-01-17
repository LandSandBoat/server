-----------------------------------------
-- ID: 5033
-- Scroll of Dextrous Etude
-- Teaches the song Dextrous Etude
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(425)
end

item_object.onItemUse = function(target)
    target:addSpell(425)
end

return item_object
