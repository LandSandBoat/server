-----------------------------------------
-- ID: 5100
-- Scroll of Boost-CHR
-- Teaches the white magic Boost-CHR
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(485)
end

item_object.onItemUse = function(target)
    target:addSpell(485)
end

return item_object
