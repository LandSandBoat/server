-----------------------------------
-- ID: 4860
-- Scroll of Stun
-- Teaches the black magic Stun
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(252)
end

item_object.onItemUse = function(target)
    target:addSpell(252)
end

return item_object
