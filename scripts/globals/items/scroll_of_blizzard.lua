-----------------------------------
-- ID: 4757
-- Scroll of Blizzard
-- Teaches the black magic Blizzard
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(149)
end

item_object.onItemUse = function(target)
    target:addSpell(149)
end

return item_object
