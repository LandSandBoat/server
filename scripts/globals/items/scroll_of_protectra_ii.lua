-----------------------------------------
-- ID: 4734
-- Scroll of Protectra II
-- Teaches the white magic Protectra II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(126)
end

item_object.onItemUse = function(target)
    target:addSpell(126)
end

return item_object
