-----------------------------------------
-- ID: 5009
-- Scroll of Hunters Prelude
-- Teaches the song Hunters Prelude
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(401)
end

item_object.onItemUse = function(target)
    target:addSpell(401)
end

return item_object
