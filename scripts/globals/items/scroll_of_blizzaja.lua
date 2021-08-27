
-----------------------------------
-- ID: 4891
-- Scroll of blizzaja
-- Teaches the black magic blizzaja
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(497)
end

item_object.onItemUse = function(target)
    target:addSpell(497)
end

return item_object
