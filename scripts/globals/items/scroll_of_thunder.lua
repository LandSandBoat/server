-----------------------------------
-- ID: 4772
-- Scroll of Thunder
-- Teaches the black magic Thunder
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(164)
end

item_object.onItemUse = function(target)
    target:addSpell(164)
end

return item_object
