-----------------------------------
-- ID: 4903
-- Dark Spirit Pact
-- Teaches the summoning magic Dark Spirit
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(295)
end

item_object.onItemUse = function(target)
    target:addSpell(295)
end

return item_object
