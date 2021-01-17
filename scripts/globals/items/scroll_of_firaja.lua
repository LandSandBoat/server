-----------------------------------------
-- ID: 4890
-- Scroll of Firaja
-- Teaches the black magic Firaja
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(496)
end

item_object.onItemUse = function(target)
    target:addSpell(496)
end

return item_object
