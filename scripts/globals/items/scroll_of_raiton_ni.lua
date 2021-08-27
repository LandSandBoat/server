-----------------------------------
-- ID: 4941
-- Scroll of Raiton: Ni
-- Teaches the ninjutsu Raiton: Ni
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(333)
end

item_object.onItemUse = function(target)
    target:addSpell(333)
end

return item_object
