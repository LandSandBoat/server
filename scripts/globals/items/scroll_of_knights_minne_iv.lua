-----------------------------------------
-- ID: 5000
-- Scroll of Knights Minne IV
-- Teaches the song Mages Ballad IV
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(392)
end

item_object.onItemUse = function(target)
    target:addSpell(392)
end

return item_object
