-----------------------------------
-- ID: 4622
-- Scroll of Poisona
-- Teaches the white magic Poisona
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(14)
end

itemObject.onItemUse = function(target)
    target:addSpell(14)
end

return itemObject
