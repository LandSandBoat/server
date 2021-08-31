-----------------------------------
-- ID: 4766
-- Scroll of Aero V
-- Teaches the black magic Aero V
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(158)
end

item_object.onItemUse = function(target)
    target:addSpell(158)
end

return item_object
