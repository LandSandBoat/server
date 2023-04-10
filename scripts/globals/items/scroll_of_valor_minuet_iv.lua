-----------------------------------
-- ID: 5005
-- Scroll of Valor Minuet IV
-- Teaches the song Valor Minuet IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(397)
end

itemObject.onItemUse = function(target)
    target:addSpell(397)
end

return itemObject
