-----------------------------------
-- ID: 4738
-- Scroll of Shellra
-- Teaches the white magic Shellra
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(130)
end

item_object.onItemUse = function(target)
    target:addSpell(130)
end

return item_object
