-----------------------------------------
-- ID: 5048
-- Scroll of Wind Carol
-- Teaches the song Wind Carol
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(440)
end

item_object.onItemUse = function(target)
    target:addSpell(440)
end

return item_object
