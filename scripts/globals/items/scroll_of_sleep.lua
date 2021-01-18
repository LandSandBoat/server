-----------------------------------
-- ID: 4861
-- Scroll of Sleep
-- Teaches the black magic Sleep
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(253)
end

item_object.onItemUse = function(target)
    target:addSpell(253)
end

return item_object
