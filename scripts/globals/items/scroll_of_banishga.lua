-----------------------------------------
-- ID: 4646
-- Scroll of Banishga
-- Teaches the white magic Banishga
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(38)
end

item_object.onItemUse = function(target)
    target:addSpell(38)
end

return item_object
