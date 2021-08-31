-----------------------------------
-- ID: 4775
-- Scroll of Thunder IV
-- Teaches the black magic Thunder IV
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(167)
end

item_object.onItemUse = function(target)
    target:addSpell(167)
end

return item_object
