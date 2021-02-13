-----------------------------------
-- ID: 4680
-- Scroll of Barsleep
-- Teaches the white magic Barsleep
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(72)
end

item_object.onItemUse = function(target)
    target:addSpell(72)
end

return item_object
