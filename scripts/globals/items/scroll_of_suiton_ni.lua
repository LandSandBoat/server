-----------------------------------
-- ID: 4944
-- Scroll of Suiton: Ni
-- Teaches the ninjutsu Suiton: Ni
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(336)
end

item_object.onItemUse = function(target)
    target:addSpell(336)
end

return item_object
