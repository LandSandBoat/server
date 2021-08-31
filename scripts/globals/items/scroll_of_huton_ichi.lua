-----------------------------------
-- ID: 4934
-- Scroll of Huton: Ichi
-- Teaches the ninjutsu Huton: Ichi
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(326)
end

item_object.onItemUse = function(target)
    target:addSpell(326)
end

return item_object
