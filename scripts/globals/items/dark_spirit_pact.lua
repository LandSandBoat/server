-----------------------------------
-- ID: 4903
-- Dark Spirit Pact
-- Teaches the summoning magic Dark Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(295)
end

itemObject.onItemUse = function(target)
    target:addSpell(295)
end

return itemObject
