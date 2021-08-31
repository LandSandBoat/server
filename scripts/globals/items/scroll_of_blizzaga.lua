-----------------------------------
-- ID: 4787
-- Scroll of Blizzaga
-- Teaches the black magic Blizzaga
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(179)
end

item_object.onItemUse = function(target)
    target:addSpell(179)
end

return item_object
