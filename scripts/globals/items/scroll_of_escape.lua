-----------------------------------
-- ID: 4871
-- Scroll of Escape
-- Teaches the black magic Escape
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(263)
end

item_object.onItemUse = function(target)
    target:addSpell(263)
end

return item_object
