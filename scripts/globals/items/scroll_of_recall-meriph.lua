-----------------------------------
-- ID: 4689
-- Scroll of Recall-Meriph
-- Teaches the white magic Recall-Meriph
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(83)
end

item_object.onItemUse = function(target)
    target:addSpell(83)
end

return item_object
