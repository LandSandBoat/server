-----------------------------------
-- ID: 4641
-- Scroll of Diaga
-- Teaches the white magic Diaga
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(33)
end

item_object.onItemUse = function(target)
    target:addSpell(33)
end

return item_object
