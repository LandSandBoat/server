-----------------------------------
-- ID: 4873
-- Scroll of Retrace
-- Teaches the black magic Retrace
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(241)
end

item_object.onItemUse = function(target)
    target:addSpell(241)
end

return item_object
