-----------------------------------
-- ID: 4900
-- Thunder Spirit Pact
-- Teaches the summoning magic Thunder Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(292)
end

itemObject.onItemUse = function(target)
    target:addSpell(292)
end

return itemObject
