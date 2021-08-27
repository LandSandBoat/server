-----------------------------------
-- ID: 4729
-- Scroll of Teleport-Altep
-- Teaches the white magic Teleport-Altep
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(121)
end

item_object.onItemUse = function(target)
    target:addSpell(121)
end

return item_object
