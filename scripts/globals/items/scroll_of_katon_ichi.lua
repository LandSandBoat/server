-----------------------------------
-- ID: 4928
-- Scroll of Katon: Ichi
-- Teaches the ninjutsu Katon: Ichi
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(320)
end

item_object.onItemUse = function(target)
    target:addSpell(320)
end

return item_object
