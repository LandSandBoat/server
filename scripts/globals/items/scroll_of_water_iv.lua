-----------------------------------
-- ID: 4780
-- Scroll of Water IV
-- Teaches the black magic Water IV
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(172)
end

item_object.onItemUse = function(target)
    target:addSpell(172)
end

return item_object
