-----------------------------------
-- ID: 4782
-- Scroll of Firaga
-- Teaches the black magic Firaga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(174)
end

itemObject.onItemUse = function(target)
    target:addSpell(174)
end

return itemObject
