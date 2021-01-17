-----------------------------------------
-- ID: 5017
-- Scroll of Scops Operetta
-- Teaches the song Scops Operetta
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(409)
end

item_object.onItemUse = function(target)
    target:addSpell(409)
end

return item_object
