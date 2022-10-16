-----------------------------------
-- ID: 4899
-- Earth Spirit Pact
-- Teaches the summoning magic Earth Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(291)
end

itemObject.onItemUse = function(target)
    target:addSpell(291)
end

return itemObject
