-----------------------------------
-- ID: 4955
-- Scroll of Kurayami: Ichi
-- Teaches the ninjutsu Kurayami: Ichi
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(347)
end

item_object.onItemUse = function(target)
    target:addSpell(347)
end

return item_object
