-----------------------------------------
-- ID: 4998
-- Scroll of Knights Minne II
-- Teaches the song Mages Ballad II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(390)
end

item_object.onItemUse = function(target)
    target:addSpell(390)
end

return item_object
