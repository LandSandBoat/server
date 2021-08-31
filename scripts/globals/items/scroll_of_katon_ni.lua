-----------------------------------
-- ID: 4929
-- Scroll of Katon: Ni
-- Teaches the ninjutsu Katon: Ni
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(321)
end

item_object.onItemUse = function(target)
    target:addSpell(321)
end

return item_object
