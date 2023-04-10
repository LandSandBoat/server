-----------------------------------
-- ID: 4901
-- Water Spirit Pact
-- Teaches the summoning magic Water Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(293)
end

itemObject.onItemUse = function(target)
    target:addSpell(293)
end

return itemObject
