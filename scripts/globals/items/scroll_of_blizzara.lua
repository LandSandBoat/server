-----------------------------------
-- ID: 4918
-- Scroll of Blizzara
-- Teaches the black magic Blizzara
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(830)
end

item_object.onItemUse = function(target)
    target:addSpell(830)
end

return item_object
