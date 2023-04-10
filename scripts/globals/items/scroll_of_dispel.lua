-----------------------------------
-- ID: 4868
-- Scroll of Dispel
-- Teaches the black magic Dispel
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(260)
end

itemObject.onItemUse = function(target)
    target:addSpell(260)
end

return itemObject
