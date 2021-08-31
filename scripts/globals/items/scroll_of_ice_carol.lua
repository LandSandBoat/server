-----------------------------------
-- ID: 5047
-- Scroll of Ice Carol
-- Teaches the song Ice Carol
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(439)
end

item_object.onItemUse = function(target)
    target:addSpell(439)
end

return item_object
