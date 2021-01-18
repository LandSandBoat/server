-----------------------------------
-- ID: 4815
-- Scroll of Freeze II
-- Teaches the black magic Freeze II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(207)
end

item_object.onItemUse = function(target)
    target:addSpell(207)
end

return item_object
