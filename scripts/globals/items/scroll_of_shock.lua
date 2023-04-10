-----------------------------------
-- ID: 4847
-- Scroll of Shock
-- Teaches the black magic Shock
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(239)
end

itemObject.onItemUse = function(target)
    target:addSpell(239)
end

return itemObject
