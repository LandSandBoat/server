-----------------------------------
-- ID: 4732
-- Scroll of Teleport-Mea
-- Teaches the white magic Teleport-Mea
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(124)
end

item_object.onItemUse = function(target)
    target:addSpell(124)
end

return item_object
