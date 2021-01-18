-----------------------------------
-- ID: 4798
-- Scroll of Stonega II
-- Teaches the black magic Stonega II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(190)
end

item_object.onItemUse = function(target)
    target:addSpell(190)
end

return item_object
