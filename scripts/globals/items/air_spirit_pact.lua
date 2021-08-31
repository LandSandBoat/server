-----------------------------------
-- ID: 4898
-- Air Spirit Pact
-- Teaches the summoning magic Air Spirit
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(290)
end

item_object.onItemUse = function(target)
    target:addSpell(290)
end

return item_object
