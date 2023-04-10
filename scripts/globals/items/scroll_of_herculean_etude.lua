-----------------------------------
-- ID: 5039
-- Scroll of Herculean Etude
-- Teaches the song Herculean Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(431)
end

itemObject.onItemUse = function(target)
    target:addSpell(431)
end

return itemObject
