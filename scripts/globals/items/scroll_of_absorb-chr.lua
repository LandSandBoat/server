-----------------------------------------
-- ID: 4880
-- Scroll of Absorb-CHR
-- Teaches the black magic Absorb-CHR
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(272)
end

item_object.onItemUse = function(target)
    target:addSpell(272)
end

return item_object
