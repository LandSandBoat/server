-----------------------------------
-- ID: 4636
-- Scroll of Banish
-- Teaches the white magic Banish
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(28)
end

item_object.onItemUse = function(target)
    target:addSpell(28)
end

return item_object
