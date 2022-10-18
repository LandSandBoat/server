-----------------------------------
-- ID: 4898
-- Air Spirit Pact
-- Teaches the summoning magic Air Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(290)
end

itemObject.onItemUse = function(target)
    target:addSpell(290)
end

return itemObject
