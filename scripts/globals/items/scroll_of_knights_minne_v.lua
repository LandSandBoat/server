-----------------------------------------
-- ID: 5001
-- Scroll of Knights Minne V
-- Teaches the song Mages Ballad V
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(393)
end

item_object.onItemUse = function(target)
    target:addSpell(393)
end

return item_object
