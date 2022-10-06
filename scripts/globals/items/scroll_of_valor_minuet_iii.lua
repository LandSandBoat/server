-----------------------------------
-- ID: 5004
-- Scroll of Valor Minuet III
-- Teaches the song Valor Minuet III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(396)
end

itemObject.onItemUse = function(target)
    target:addSpell(396)
end

return itemObject
