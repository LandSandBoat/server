-----------------------------------
-- ID: 4901
-- Water Spirit Pact
-- Teaches the summoning magic Water Spirit
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(293)
end

item_object.onItemUse = function(target)
    target:addSpell(293)
end

return item_object
