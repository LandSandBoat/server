-----------------------------------
-- ID: 5040
-- Scroll of Uncanny Etude
-- Teaches the song Uncanny Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(432)
end

itemObject.onItemUse = function(target)
    target:addSpell(432)
end

return itemObject
