-----------------------------------
-- ID: 5002
-- Scroll of Valor Minuet
-- Teaches the song Valor Minuet
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(394)
end

itemObject.onItemUse = function(target)
    target:addSpell(394)
end

return itemObject
