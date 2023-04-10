-----------------------------------
-- ID: 4625
-- Scroll of Silena
-- Teaches the white magic Silena
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(17)
end

itemObject.onItemUse = function(target)
    target:addSpell(17)
end

return itemObject
