-----------------------------------
-- ID: 4820
-- Scroll of Burst
-- Teaches the black magic Burst
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(212)
end

item_object.onItemUse = function(target)
    target:addSpell(212)
end

return item_object
