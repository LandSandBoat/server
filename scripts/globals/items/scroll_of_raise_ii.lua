-----------------------------------
-- ID: 4621
-- Scroll of Raise II
-- Teaches the white magic Raise II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(13)
end

item_object.onItemUse = function(target)
    target:addSpell(13)
end

return item_object
