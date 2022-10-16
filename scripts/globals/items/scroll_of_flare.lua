-----------------------------------
-- ID: 4812
-- Scroll of Flare
-- Teaches the black magic Flare
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(204)
end

itemObject.onItemUse = function(target)
    target:addSpell(204)
end

return itemObject
