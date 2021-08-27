-----------------------------------
-- ID: 4870
-- Scroll of Warp II
-- Teaches the black magic Warp II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(262)
end

item_object.onItemUse = function(target)
    target:addSpell(262)
end

return item_object
