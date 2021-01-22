-----------------------------------
-- ID: 4695
-- Scroll of Barpoisonra
-- Teaches the white magic Barpoisonra
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(87)
end

item_object.onItemUse = function(target)
    target:addSpell(87)
end

return item_object
