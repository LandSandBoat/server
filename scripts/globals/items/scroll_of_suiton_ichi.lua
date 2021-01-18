-----------------------------------
-- ID: 4943
-- Scroll of Suiton: Ichi
-- Teaches the ninjutsu Suiton: Ichi
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(335)
end

item_object.onItemUse = function(target)
    target:addSpell(335)
end

return item_object
