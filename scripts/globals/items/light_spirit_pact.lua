-----------------------------------
-- ID: 4902
-- Light Spirit Pact
-- Teaches the summoning magic Air Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(294)
end

itemObject.onItemUse = function(target)
    target:addSpell(294)
end

return itemObject
