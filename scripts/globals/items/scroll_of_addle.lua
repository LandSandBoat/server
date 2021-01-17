-----------------------------------------
-- ID: Unknown
-- Scroll of Addle
-- Teaches the magic Addle
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(286)
end

item_object.onItemUse = function(target)
    target:addSpell(286)
end

return item_object
