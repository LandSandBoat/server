-----------------------------------
-- ID: 4714
-- Scroll of Phalanx
-- Teaches the white magic Phalanx
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(106)
end

item_object.onItemUse = function(target)
    target:addSpell(106)
end

return item_object
