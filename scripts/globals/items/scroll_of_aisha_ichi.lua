-----------------------------------
-- ID: 4965
-- Scroll of Aisha: Ichi
-- Teaches the ninjutsu Aisha: Ichi
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(319)
end

item_object.onItemUse = function(target)
    target:addSpell(319)
end

return item_object
