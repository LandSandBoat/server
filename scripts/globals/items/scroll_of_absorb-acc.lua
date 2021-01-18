-----------------------------------
-- ID: 4886
-- Scroll of Absorb-ACC
-- Teaches the black magic Absorb-ACC
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(242)
end

item_object.onItemUse = function(target)
    target:addSpell(242)
end

return item_object
