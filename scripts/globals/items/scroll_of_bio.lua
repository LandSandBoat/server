-----------------------------------
-- ID: 4838
-- Scroll of Bio
-- Teaches the black magic Bio
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(230)
end

item_object.onItemUse = function(target)
    target:addSpell(230)
end

return item_object
