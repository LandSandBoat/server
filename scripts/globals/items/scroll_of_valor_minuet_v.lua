-----------------------------------
-- ID: 5006
-- Scroll of Valor Minuet V
-- Teaches the song Valor Minuet V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(398)
end

itemObject.onItemUse = function(target)
    target:addSpell(398)
end

return itemObject
