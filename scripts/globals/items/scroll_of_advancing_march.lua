-----------------------------------
-- ID: 5027
-- Scroll of Advancing March
-- Teaches the song Advancing March
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(419)
end

item_object.onItemUse = function(target)
    target:addSpell(419)
end

return item_object
