-----------------------------------
-- ID: 4897
-- Ice Spirit Pact
-- Teaches the summoning magic ice Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(289)
end

itemObject.onItemUse = function(target)
    target:addSpell(289)
end

return itemObject
