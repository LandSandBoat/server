-----------------------------------
-- ID: 4922
-- Scroll of Stonera
-- Teaches the black magic Stonera
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(834)
end

item_object.onItemUse = function(target)
    target:addSpell(834)
end

return item_object
