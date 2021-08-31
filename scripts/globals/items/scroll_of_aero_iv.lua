-----------------------------------
-- ID: 4765
-- Scroll of Aero IV
-- Teaches the black magic Aero IV
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(157)
end

item_object.onItemUse = function(target)
    target:addSpell(157)
end

return item_object
