-----------------------------------
-- ID: 4784
-- Scroll of Firaga III
-- Teaches the black magic Firaga III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(176)
end

itemObject.onItemUse = function(target)
    target:addSpell(176)
end

return itemObject
