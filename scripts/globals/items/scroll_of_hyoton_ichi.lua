-----------------------------------
-- ID: 4931
-- Scroll of Hyoton: Ichi
-- Teaches the ninjutsu Hyoton: Ichi
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(323)
end

item_object.onItemUse = function(target)
    target:addSpell(323)
end

return item_object
