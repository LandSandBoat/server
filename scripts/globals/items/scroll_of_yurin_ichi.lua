-----------------------------------
-- ID: 4967
-- Scroll of Yurin: Ichi
-- Teaches the ninjutsu Yurin: Ichi
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(508)
end

item_object.onItemUse = function(target)
    target:addSpell(508)
end

return item_object
