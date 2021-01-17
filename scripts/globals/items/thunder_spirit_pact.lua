-----------------------------------------
-- ID: 4900
-- Thunder Spirit Pact
-- Teaches the summoning magic Thunder Spirit
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(292)
end

item_object.onItemUse = function(target)
    target:addSpell(292)
end

return item_object
