-----------------------------------------
-- ID: 4752
-- Scroll of Fire
-- Teaches the black magic Fire
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(144)
end

item_object.onItemUse = function(target)
    target:addSpell(144)
end

return item_object
