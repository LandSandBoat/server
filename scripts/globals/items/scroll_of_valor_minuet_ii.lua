-----------------------------------
-- ID: 5003
-- Scroll of Valor Minuet II
-- Teaches the song Valor Minuet II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(395)
end

itemObject.onItemUse = function(target)
    target:addSpell(395)
end

return itemObject
