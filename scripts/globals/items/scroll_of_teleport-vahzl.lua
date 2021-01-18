-----------------------------------
-- ID: 4747
-- Scroll of Teleport-Vahzl
-- Teaches the white magic Teleport-Vahzl
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(139)
end

item_object.onItemUse = function(target)
    target:addSpell(139)
end

return item_object
