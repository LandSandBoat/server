-----------------------------------
-- ID: 4741
-- Scroll of Shellra IV
-- Teaches the white magic Shellra IV
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(133)
end

item_object.onItemUse = function(target)
    target:addSpell(133)
end

return item_object
