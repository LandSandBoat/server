-----------------------------------------
-- ID: 4819
-- Scroll of Quake II
-- Teaches the black magic Quake II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(211)
end

item_object.onItemUse = function(target)
    target:addSpell(211)
end

return item_object
